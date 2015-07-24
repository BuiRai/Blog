class Article < ActiveRecord::Base
	#include this module, from the gem AASM
	include AASM

	# la tabla ==> articles
	#campos ==> article.title() ==> 'El título'
	#Escribir métodos

	belongs_to :user #One to Many, an article belong to only one user
	
	#One to Many, An article has a lot of comments
	has_many :comments

	

	#Many to Many, an article has a lot of categories throught the table 'HasCategory'
	has_many :has_categories
	has_many :categories, through: :has_categories

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

	#scope to bring published articles
	scope :publicados, ->{ where(state: "published") }

	#scope to bring the 10 latest articles
	scope :ultimos, ->{ order("created_at DESC") }

	#Custom setter
	def categories=(value)
		@categories = value
	end

	def update_visits_count
		self.update(visits_count: self.visits_count + 1)
	end

	#----------------------------------------------------------
	#TO change state from stage type on the console of rails:
	#Article.(item).publish! or
	#Article.(item).unpublish! or
	#And to check just type on the rails console
	#Article Article.(item).may_publish? or
	#Article Article.(item).may_unpublish?
	#----------------------------------------------------------
	#AASM
	aasm column: "state" do
		#states
		state :in_draft, initial: true
		state :published

		#transitions, publish and unpublish
		event :publish do
			transitions from: :in_draft, to: :published
		end
		event :unpublish do
			transitions from: :published, to: :in_draft
		end
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
