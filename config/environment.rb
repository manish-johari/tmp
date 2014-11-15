# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# configration setting to send email.
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings =
{
 :address              => "smtp.gmail.com",
 :port                 => 587,
 :domain               => "gmail.com",
 :user_name            => APP_CONFIG[:GMAIL_USERNAME],
 :password             => APP_CONFIG[:GMAIL_PASSWORD],
 :authentication       => "plain",
 :enable_starttls_auto => true
 }
Rails.application.routes.default_url_options[:host] = APP_CONFIG[:APP_DOMAIN]