# frozen_string_literal: true

require 'application_system_test_case'

class ApplicationTest < ApplicationSystemTestCase
  include ActionMailer::TestHelper

  test 'viewing the homepage' do
    visit homepage_path

    assert_selector 'header', class: 's-topbar'
    assert_selector 'div', id: 'left-sidebar'
    assert_selector 'div', id: 'mainbar'
    assert_selector 'div', id: 'sidebar'
  end

  test 'inbox link opens a popover' do
    visit homepage_path

    assert_link 'Inbox'
    click_on 'Inbox'
    assert_selector 'div#inbox-popover', visible: true
  end

  test 'viewing the signin page' do
    visit sign_in_path

    assert_selector 'div', class: 'sign-in'
  end

  test 'sending an email via the signin page' do
    visit sign_in_path

    assert_selector 'form', id: 'email-form'
    fill_in 'Email', with: 'capybara@minitest.com'
    fill_in 'message', with: 'great portfolio site!'

    assert_emails 1 do
      click_on 'Email Chip'
      assert_selector 'div#email-sent-toast', visible: true
    end
  end

  test 'seeing the phone number on the signin page' do
    visit sign_in_path

    assert_button 'Call Chip'
    click_on 'Call Chip'
    assert_text 'Call or text Chip:'
  end

  test 'bad url redirects to signin' do
    visit '/nowhere'

    assert_text "It's not really the 'Sign in' kind of app..."

    visit '/'

    assert_text 'All Questions'

    visit '/wp-admin'

    assert_text "It's not really the 'Sign in' kind of app..."
  end
end
