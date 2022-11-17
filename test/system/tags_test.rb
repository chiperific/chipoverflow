# frozen_string_literal: true

require 'application_system_test_case'

class TagsTest < ApplicationSystemTestCase
  # test 'has index page' do
  #   visit tags_path

  #   assert_text 'Tags'

  #   assert_text 'FixtureTag'
  #   assert_text 'FixtureSearchTag'
  #   assert_text 'FixtureUnfoundTag'
  # end

  test 'can be live searched' do
    visit tags_path

    assert_text 'Tags'

    fill_in 'name_search', with: 'search'

    assert_no_text 'FixtureTag'
    assert_text 'FixtureSearchTag'
    assert_no_text 'FixtureUnfoundTag'

    fill_in 'name_search', with: 'found'

    assert_no_text 'FixtureTag'
    assert_no_text 'FixtureSearchTag'
    assert_text 'FixtureUnfoundTag'
  end

  test 'can search questions by tag' do
    valid_tag = tags(:valid)
    search_tag = tags(:search)

    question = posts(:valid_question)
    question.tags << valid_tag
    question.tags << search_tag

    question_two = posts(:question_two)
    question_two.tags << search_tag

    visit search_tags_path(tag_name: valid_tag.name)

    assert_text "Questions tagged '#{valid_tag.name}':"

    assert_text question.title
    assert_no_text question_two.title

    visit search_tags_path(tag_name: search_tag.name)

    assert_text "Questions tagged '#{search_tag.name}':"

    assert_text question.title
    assert_text question_two.title
  end
end
