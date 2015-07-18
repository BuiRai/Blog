class Article < ActiveRecord::Base
	# la tabla ==> articles
	#campos ==> article.title() ==> 'El título'
	#Escribir métodos
	validates :title, presence: true #validates the title if is null
	validates :body, presence: true #validates the body if is null
end
