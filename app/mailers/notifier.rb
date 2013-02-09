class Notifier < ActionMailer::Base
  default from: "trupti.coen280@gmail.com"

   require 'tlsmail'
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
  def welcome_email(employee)
    @employee = employee
    @email = employee.email
    mail(:to => @email, :subject => "Welcome to Expense tracker web site")
  end

  def expense_approved_email(expense)
    @expense = expense
    @email = expense.employee.email
    mail(:to => @email, :subject => "Your Expense has been Approved")
  end

  def expense_declined_email(expense)
    @expense = expense
    @email = expense.employee.email
    mail(:to => @email, :subject => "Your Expense has been Declined")
  end

  def expense_max_expensable_email(initial_amount,expense)
    @expense = expense
    @email = expense.employee.email
    @init_amount =   initial_amount
    mail(:to => @email, :subject => "Your Expense has been partial amount approved and remaining is pending")
  end
end
