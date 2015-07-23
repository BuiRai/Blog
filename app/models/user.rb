class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 	has_many :articles #One to Many, a user can have a lot of articles
 	has_many :comments #One to Many, a user can have a lot of comments
 	include PermissionsConcern
end
