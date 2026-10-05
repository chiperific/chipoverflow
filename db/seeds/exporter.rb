# frozen_string_literal: true

require "fileutils"
require "yaml"

## =====> Hello, Interviewers!
#
# I wanted the comfort of writing these posts in a dev env
# And the convenience of not having to re-write them in prod
# And, even if I didn't want to spin up a dev env, I could just edit the yaml files
# But I also want to keep the database and the yaml files in sync

module Seeds
  class Exporter
    class Error < StandardError; end

    AUTHOR_ATTRIBUTES = %w[id name reputation gold silver bronze gravatar_url].freeze
    TAG_ATTRIBUTES = %w[id description score].freeze
    POST_ATTRIBUTES = %w[id title title_slug accepted views votes rank published_at].freeze
    COMMENT_ATTRIBUTES = %w[votes published_at].freeze
    private_constant :AUTHOR_ATTRIBUTES, :TAG_ATTRIBUTES, :POST_ATTRIBUTES, :COMMENT_ATTRIBUTES

    class LiteralString < String
      def encode_with(coder)
        coder.tag = "tag:yaml.org,2002:str"
        coder.scalar = to_s
        coder.style = Psych::Nodes::Scalar::LITERAL
      end
    end

    def initialize(root: Rails.root.join("db/seeds"))
      @root = Pathname(root)
      @author_keys = build_author_keys
    end

    def call
      FileUtils.mkdir_p(threads_path)
      write_yaml(root.join("authors.yml"), authors_data)
      write_yaml(root.join("tags.yml"), tags_data)
      root.join("threads").glob("*.yml").each(&:delete)
      Post.only_questions.order(:id).find_each { |question| write_thread(question) }
    end

    private

    attr_reader :root, :author_keys

    def build_author_keys
      keys = Author.order(:id).to_h { |author| [author.id, author.name.parameterize] }
      duplicates = keys.values.tally
        .select { |_key, count| count > 1 }
        .keys
      raise Error, "Duplicate author keys: #{duplicates.join(", ")}" if duplicates.any?

      keys
    end

    def authors_data
      Author.order(:id).to_h do |author|
        [author_keys[author.id], author.attributes.slice(*AUTHOR_ATTRIBUTES)]
      end
    end

    def tags_data
      Tag.order(:id).to_h do |tag|
        [tag.name, tag.attributes.slice(*TAG_ATTRIBUTES)]
      end
    end

    def write_thread(question)
      data = {
        "question" => post_data(question),
        "answers" => question.answers.order(:id).map { |answer| post_data(answer) }
      }
      filename = format("%<id>02d-%<slug>s.yml", id: question.id, slug: question.title_slug.downcase)
      write_yaml(threads_path.join(filename), data)
    end

    def post_data(post)
      data = post.attributes.slice(*POST_ATTRIBUTES)
      data.delete("title") if data["title"].nil?
      data.delete("title_slug") if data["title_slug"].blank?
      data["published_at"] = post.published_at&.to_s
      data["author"] = author_keys[post.author_id]
      data["body"] = literal(post.body.to_trix_html)
      data["tags"] = post.tags.order(:name).pluck(:name)

      comments = post.comments.order(:id).map { |comment| comment_data(comment) }
      data["comments"] = comments if comments.any?
      data
    end

    def comment_data(comment)
      comment.attributes.slice(*COMMENT_ATTRIBUTES).merge(
        "published_at" => comment.published_at&.to_s,
        "author" => author_keys[comment.author_id],
        "body" => literal(comment.body.to_trix_html)
      )
    end

    def literal(value)
      LiteralString.new(value.to_s.gsub(/[ \t]+\n/, "\n"))
    end

    def threads_path
      root.join("threads")
    end

    def write_yaml(path, data)
      yaml = YAML.dump(data, line_width: -1).gsub("!!str ", "")
      path.write(yaml)
    end
  end
end
