class UsersMailer < ApplicationMailer
  default from: 'thierry@pensieve.cc'

  def welcome
    @greeting = "Hi"
    mail(
      subject: 'Hello from Pensieve',
      to: 'thierry.chau@gmail.com',
      html_body: '<strong>Hello</strong> dear Pensieve user.',
      track_opens: 'true',
      message_stream: 'broadcast')
  end
end
