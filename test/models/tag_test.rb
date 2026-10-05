# frozen_string_literal: true

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  subject { tags(:valid) }

  context '#calculate_score!' do
    should 'change the value of score based on predefined factors' do
      first_score = subject.score

      question = posts(:valid_question)
      subject.posts << question
      subject.save

      assert_operator first_score, :<, subject.calculate_score!
    end
  end
end
