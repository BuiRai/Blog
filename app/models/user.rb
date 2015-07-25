class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 	has_many :articles #One to Many, a user can have a lot of articles
 	has_many :comments #One to Many, a user can have a lot of comments
 	include PermissionsConcern

 	#Avatar with Gravatar
 	#If you want show your avatar you need sign in 
 	#in Gravatar an change your avatar profile
 	#To more information visit: 
 	#https://es.gravatar.com/site/implement/images/ruby/

 	def avatar
 		# get the email from URL-parameters or what have you and make lowercase
		email_address = self.email.downcase
		 
		# create the md5 hash
		hash = Digest::MD5.hexdigest(email_address)
		 
		# compile URL which can be used in <img src="RIGHT_HERE"...
		image_src = "http://www.gravatar.com/avatar/#{hash}"
 	end
end
