# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def notify_owner
    ContactMailer.notify_owner('hr@coolsoftwarecompany.com', "You're hired!")
  end
end
