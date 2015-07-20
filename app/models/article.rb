class Article < ActiveRecord::Base
	# la tabla ==> articles
	#campos ==> article.title() ==> 'El título'
	#Escribir métodos

	belongs_to :user #One to Many, an article belong to only one user
	#validates the title if is null
	#validates the title if is unique
	validates :title, presence: true, uniqueness: true

	#validates the body if is null 
	#validates if the body has a size  minimum 20 letters
	validates :body, presence: true, length: {minimum: 20}
end
