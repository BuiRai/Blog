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
	
	#Before, the value of visits_count will be initialized in 0
	before_save :set_visits_count

	#One to Many, An article has a lot of comments
	has_many :comments

	def update_visits_count
		self.update(visits_count: self.visits_count + 1)
	end

	private

	def set_visits_count
		self.visits_count ||= 0
	end
end
