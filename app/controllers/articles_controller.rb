class ArticlesController < ApplicationController
	#Before, verify if a user is logged, this is from device
	before_action :authenticate_user!, except: [:show,:index]
	before_action :set_article, except: [:index, :new, :create]
	#GET /articles
	def index
		@articles = Article.all #all the registers from the DB
	end

	#GET /articles/:id
	def show
		@article.update_visits_count
		@comment = Comment.new
	end

	#GET /articles/new
	def new
		@article = Article.new
		@categories = Category.all
	end

	def edit
		
	end

	#POST /articles
	def create
		#First create the article with params
		@article = current_user.articles.new(article_params)
		@article.categories = params[:categories]

		if @article.save  #save the articles on the DataBase
			redirect_to @article #Redirect to /articles/:id
		else
			render :new #render of the action new
		end
	end

	def destroy
		@article.destroy #Delete the object from the DB
		redirect_to articles_path
	end

	#PUT /articles/:id
	def update
		if @article.update(article_params)
			redirect_to @article
		else
			render :edit
		end
	end

	#Private
	private
	def set_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :body, :cover, :categories)
	end
end