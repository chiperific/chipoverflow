# frozen_string_literal: true

require "date"
require "pathname"
require "yaml"

module Seeds
  class Loader
    class Error < StandardError; end

    POST_ATTRIBUTES = %w[id title title_slug body accepted views votes rank published_at].freeze
    COMMENT_ATTRIBUTES = %w[body votes published_at].freeze
    private_constant :POST_ATTRIBUTES, :COMMENT_ATTRIBUTES

    def initialize(root: File.expand_path(__dir__))
      @root = Pathname(root)
      @authors = {}
      @tags = {}
      @post_ids = Set.new
    end

    def call
      ActiveRecord::Base.transaction do
        load_authors
        load_tags
        thread_files.each { |path| load_thread(path) }
        reset_primary_key_sequences
      end
    end

    private

    attr_reader :root

    def load_authors
      load_yaml(root.join("authors.yml")).each do |key, attributes|
        author = Author.new
        author.assign_attributes(attributes)
        author.save!
        @authors[key] = author
      end
    end

    def load_tags
      load_yaml(root.join("tags.yml")).each do |name, attributes|
        @tags[name] = Tag.create!(attributes.merge("name" => name))
      end
    end

    def thread_files
      root.join("threads").glob("*.yml").sort
    end

    def load_thread(path)
      thread = load_yaml(path)
      question_data = thread.fetch("question") { raise Error, "#{path}: missing question" }
      answers_data = thread.fetch("answers", [])

      raise Error, "#{path}: answers must be a list" unless answers_data.is_a?(Array)

      accepted_answers = answers_data.count { |answer| answer["accepted"] }
      raise Error, "#{path}: has more than one accepted answer" if accepted_answers > 1

      question = create_post(question_data, context: "#{path}: question")
      answers_data.each_with_index do |answer_data, index|
        create_post(answer_data, question:, context: "#{path}: answer #{index + 1}")
      end
    rescue KeyError => e
      raise Error, "#{path}: #{e.message}"
    end

    def create_post(data, context:, question: nil)
      validate_mapping(data, context)
      id = data["id"]
      raise Error, "#{context}: missing id" if id.nil?
      raise Error, "#{context}: duplicate post id #{id}" unless @post_ids.add?(id)
      raise Error, "#{context}: questions cannot be accepted answers" if question.nil? && data["accepted"]

      tags = Array(data["tags"]).map { |name| find_tag(name, context) }
      author = find_author(data["author"], context)
      attributes = data.slice(*POST_ATTRIBUTES)
      post = Post.create!(attributes.merge("author" => author, "question" => question))
      post.tags = tags

      Array(data["comments"]).each_with_index do |comment_data, index|
        create_comment(comment_data, post, "#{context}: comment #{index + 1}")
      end

      post
    end

    def create_comment(data, post, context)
      validate_mapping(data, context)
      author = find_author(data["author"], context)
      attributes = data.slice(*COMMENT_ATTRIBUTES)
      Comment.create!(attributes.merge("author" => author, "post" => post))
    end

    def find_author(key, context)
      @authors.fetch(key) { raise Error, "#{context}: unknown author #{key.inspect}" }
    end

    def find_tag(name, context)
      @tags.fetch(name) { raise Error, "#{context}: unknown tag #{name.inspect}" }
    end

    def validate_mapping(data, context)
      raise Error, "#{context}: must be a mapping" unless data.is_a?(Hash)
    end

    def load_yaml(path)
      YAML.safe_load_file(path, permitted_classes: [Date, Time], aliases: false) || {}
    rescue Psych::Exception => e
      raise Error, "#{path}: #{e.message}"
    end

    def reset_primary_key_sequences
      connection = ActiveRecord::Base.connection
      return unless connection.respond_to?(:reset_pk_sequence!)

      connection.tables.each { |table| connection.reset_pk_sequence!(table) }
    end
  end
end
