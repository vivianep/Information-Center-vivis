class User < ActiveRecord::Base
	validates_presence_of :name, :email
	validates_uniqueness_of :email

	def self.cache_photo(user_id)
		Rails.cache.fetch("photo_url") do 
			User.find(user_id).photo_url
		end
	end

end
