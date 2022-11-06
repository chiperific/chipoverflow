# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  default from: 'contact@chipoverflow.com'

  def notify_owner(email, message)
    @email = email
    @message = message

    mail(
      to: 'chiperific@gmail.com',
      subject: 'Chipoverflow got a response!'
    )
  end
end
