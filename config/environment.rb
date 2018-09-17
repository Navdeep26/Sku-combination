# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :domain         => 'localhost:3000',
  :port           => 587,
  :user_name      => '@gmail.com',
  :password       => 'password',
  :authentication => :plain,
  :enable_starttls_auto => true
}
