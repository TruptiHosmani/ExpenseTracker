# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ExpenseDB::Application.initialize!

ActionMailer::Base.delivery_method = :smtp
   Net.instance_eval {remove_const :SMTPSession} if defined?(SMTPSession)
   Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
   ActionMailer::Base.delivery_method = :smtp
   ActionMailer::Base.perform_deliveries = true
   ActionMailer::Base.raise_delivery_errors = true
   ActionMailer::Base.smtp_settings = {
   :enable_starttls_auto => true,
   :address            => 'smtp.gmail.com',
   :port               => 587,
   :tls                  => true,
   :domain             => 'trupti.coen280@gmail.com',
   :authentication     => :plain,
   :user_name          => 'trupti.coen280@gmail.com',
   :password           => 'coen280DBMS' # for security reasons you can use a environment variable too. (ENV['INFO_MAIL_PASS'])
   }
