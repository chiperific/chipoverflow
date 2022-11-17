# frozen_string_literal: true

require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase
  test 'search using header searchbar' do
    Post.create(title: 'has the magic word in the title: blurg', body: 'is just some text')
    Post.create(title: 'is just a title', body: 'has the magic word in the body: blurg')
    Post.create(title: 'has no magic word anywhere', body: 'is just some text')

    question = Post.create(title: 'has the magic word in the answer', body: 'is just some text')

    Post.create(title: 'is an answer with the magic word in the body', body: 'the magic word is blurg, so the question should be listed', question_id: question.reload.id)

    visit homepage_path

    assert_selector 'input[name="q"]'

    fill_in 'q', with: 'blurg'

    find('#q').native.send_keys(:return)

    assert_text 'Search Results'

    assert_text 'has the magic word in the title: blurg'
    assert_text 'is just a title'
    assert_no_text 'has no magic word anywhere'
    assert_text 'has the magic word in the answer'
  end

  test 'showing a question' do
    question = posts(:valid_question)
    answer = posts(:valid_answer)
    accepted_answer = posts(:valid_accepted_answer)

    visit show_post_path(id: question.id, title_slug: question.title_slug)

    assert_text question.title
    assert_text question.author.name
    assert_text answer.author.name
    assert_text accepted_answer.author.name
  end

  test 'posts have upvote, downvote and bookmark buttons' do
    question = posts(:valid_question)
    answer = posts(:valid_answer)
    accepted_answer = posts(:valid_accepted_answer)

    visit show_post_path(id: question.id, title_slug: question.title_slug)

    assert_selector "div[data-posts-id-value='#{question.id}'] button.upvote"
    assert_selector "div[data-posts-id-value='#{question.id}'] button.downvote"
    assert_selector "div[data-posts-id-value='#{question.id}'] button.bookmark"

    assert_selector "div[data-posts-id-value='#{answer.id}'] button.upvote"
    assert_selector "div[data-posts-id-value='#{answer.id}'] button.downvote"
    assert_selector "div[data-posts-id-value='#{answer.id}'] button.bookmark"

    assert_selector "div[data-posts-id-value='#{accepted_answer.id}'] button.upvote"
    assert_selector "div[data-posts-id-value='#{accepted_answer.id}'] button.downvote"
    assert_selector "div[data-posts-id-value='#{accepted_answer.id}'] button.bookmark"
  end
end
