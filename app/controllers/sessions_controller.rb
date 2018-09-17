class SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token  

	def show
		@img_path = Rails.root.join('public', 'twitter.png')
		# raise "#{@current_user.to_json}..........#{session.to_json}"
		if @current_user.present?
			render "dashboard"
		end
	end

	def create
		if params[:name].present? && params[:email].present? && params[:password].present?
			user = User.find_by_email(params[:email])
			if user.present?
				render "dashboard"
			else
				user = User.new
				user.name = params[:name]
				user.email = params[:email]
				user.password = Base64.encode64(params[:password])
				if user.save
					session[:user_id] = user.id
					redirect_to root_path
				end
			end
		elsif request.env["omniauth.auth"].present?
			auth = request.env["omniauth.auth"]
			if auth['uid'].present? 
				user = User.find_by_p_id(auth['uid'])
				if user.present?
					session[:user_id] = user.id
					render "dashboard"
					# render plain: "Already Signed In"
				else
					user = User.create_with_omniauth(auth)
					session[:user_id] = user.id
					redirect_to root_path
					# render :plain => "Sucessfully Signed In"
				end
			else
				render :plain => "params value is not present"
			end
		end

		# raise "#{auth.to_json}"
		# user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
		# session[:user_id] = user.id
		# redirect_to tweets_path, :notice => "Sucessfully Signed In"

	end

	def log_in
		if params[:email].present? && params[:password].present?
			user = User.find_by_email(params[:email])
			if user.present? && (user.password == Base64.encode64(params[:password]))
				session[:user_id] = user.id
				redirect_to root_path
			else
				render :plain => "User not found please sign up"
			end
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path, :notice => "Sucessfully Signed Out"
	end
end