class User < ApplicationRecord

	def self.create_with_omniauth(auth)
		user = User.new
		user.p_id = auth["uid"].to_s
		user.name = auth["info"]["name"]
		user.email = auth["info"]["email"]
		user.save
		return user
	end
end