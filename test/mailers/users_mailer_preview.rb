# Test me at /rails/mailers/users_mailer
class UsersMailerPreview < ActionMailer::Preview
  def welcome
    UsersMailer.with(user: User.first).welcome
  end
end
