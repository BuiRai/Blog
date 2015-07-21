class Comment < ActiveRecord::Base
  #One to Many, a comment belong to only one Article
  belongs_to :user

  #One to Many, a comment belong to only one User
  belongs_to :article
end
