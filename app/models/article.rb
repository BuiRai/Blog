class Article < ActiveRecord::Base
	# la tabla ==> articles
	#campos ==> article.title() ==> 'El título'
	#Escribir métodos

	belongs_to :user #One to Many, an article belong to only one user
	
	#One to Many, An article has a lot of comments
	has_many :comments

	#validates the title if is null
	#validates the title if is unique
	validates :title, presence: true, uniqueness: true

	#validates the body if is null 
	#validates if the body has a size  minimum 20 letters
	validates :body, presence: true, length: {minimum: 20}
	
	#Before, the value of visits_count will be initialized in 0
	before_save :set_visits_count

	#After, show information, or errors
	after_create :save_categories

	#--==--This is for paperclip (a gem)--==--
	has_attached_file :cover, styles: { medium:"1280x720", thumb:"800x600" }

	#For security, upload the type we want, this is from paperclip.
	#in this case the mean of /\Aimage\/.*\Z/ is an image of any extension.
	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

	#Custom setter
	def categories=(value)
		@categories = value
	end

	def update_visits_count
		self.update(visits_count: self.visits_count + 1)
	end

	private

	def save_categories
		@categories.each do |category_id|
			HasCategory.create(category_id: category_id, article_id: self.id)
		end
	end

	def set_visits_count
		self.visits_count ||= 0
	end
end
