class EmailerMailer < ApplicationMailer
	default from: 'navdeepkumar2028@gmail.com'
 
  def send_email_to_current_user(user, no_of_entry)
    @user = user
    @no_of_entry = no_of_entry
    mail(to: @user.email, subject: 'Data sucessfully created', template_name: "send_email")
  end
end
