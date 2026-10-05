# frozen_string_literal: true

require 'test_helper'
require 'tmpdir'
require Rails.root.join('db/seeds/loader')

class Seeds::LoaderTest < ActiveSupport::TestCase
  setup do
    Comment.delete_all
    Post.delete_all
    Tag.delete_all
    Author.delete_all

    @seed_root = Pathname(Dir.mktmpdir)
    @seed_root.join('threads').mkpath
    write_yaml('authors.yml', authors_data)
    write_yaml('tags.yml', tags_data)
    write_yaml('threads/testing.yml', thread_data)
  end

  teardown do
    FileUtils.remove_entry(@seed_root)
  end

  test 'creates a complete question thread from semantic references' do
    Seeds::Loader.new(root: @seed_root).call

    question = Post.find(100)
    answer = Post.find(101)

    assert_equal 'Alice Author', question.author.name
    assert_equal ['ruby'], question.tags.pluck(:name)
    assert_equal answer, question.answers.first
    assert answer.accepted?
    assert_equal 'Bob Commenter', question.comments.first.author.name
    assert_equal 'A useful comment', question.comments.first.body.to_plain_text
  end

  test 'rolls back all records when an author reference is unknown' do
    data = thread_data
    data['question']['author'] = 'missing-author'
    write_yaml('threads/testing.yml', data)

    error =
      assert_raises(Seeds::Loader::Error) do
        Seeds::Loader.new(root: @seed_root).call
      end

    assert_match(/unknown author "missing-author"/, error.message)
    assert_equal 0, Author.count
    assert_equal 0, Tag.count
    assert_equal 0, Post.count
  end

  test 'rejects multiple accepted answers' do
    data = thread_data
    data['answers'] << data['answers'].first.deep_dup.merge('id' => 102)
    write_yaml('threads/testing.yml', data)

    error =
      assert_raises(Seeds::Loader::Error) do
        Seeds::Loader.new(root: @seed_root).call
      end

    assert_match(/more than one accepted answer/, error.message)
  end

  private

  def authors_data
    {
      'alice' => {
        'id' => 10,
        'name' => 'Alice Author',
        'reputation' => 100,
        'gold' => 1,
        'silver' => 2,
        'bronze' => 3,
        'gravatar_url' => 'https://example.com/alice.png'
      },
      'bob' => {
        'id' => 11,
        'name' => 'Bob Commenter',
        'reputation' => 50,
        'gold' => 0,
        'silver' => 1,
        'bronze' => 2,
        'gravatar_url' => 'https://example.com/bob.png'
      }
    }
  end

  def tags_data
    {
      'ruby' => {
        'id' => 20,
        'description' => 'The Ruby language',
        'score' => 0
      }
    }
  end

  def thread_data
    {
      'question' => {
        'id' => 100,
        'author' => 'alice',
        'title' => 'How does the seed loader work?',
        'body' => '<div>A seeded question</div>',
        'accepted' => false,
        'views' => 10,
        'votes' => 2,
        'rank' => 16,
        'published_at' => '2024-01-01 12:00:00 UTC',
        'tags' => ['ruby'],
        'comments' => [
          {
            'author' => 'bob',
            'body' => '<div>A useful comment</div>',
            'votes' => 1,
            'published_at' => '2024-01-01 13:00:00 UTC'
          }
        ]
      },
      'answers' => [
        {
          'id' => 101,
          'author' => 'bob',
          'body' => '<div>A seeded answer</div>',
          'accepted' => true,
          'views' => 5,
          'votes' => 3,
          'rank' => 14,
          'published_at' => '2024-01-01 14:00:00 UTC',
          'tags' => []
        }
      ]
    }
  end

  def write_yaml(relative_path, data)
    @seed_root.join(relative_path).write(YAML.dump(data))
  end
end
