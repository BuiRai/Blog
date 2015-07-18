class ArticlesController < ApplicationController
	
	#GET /articles
	def index
		@articles = Article.all
	end

	#GET /articles/:id
	def show
		@article = Article.find(params[:id]);
	end

	#GET /articles/new
	def new
		@article = Article.new
	end

	#POST /articles
	def create
		#First create the article with params
		@article = Article.new(title:params[:article][:title], body: params[:article][:body])
		
		if @article.save  #save the articles on the DataBase
			redirect_to @article #Redirect to /articles/:id
		else
			render :new #render of the action new
		end
		
		
	end

	#PUT /articles/:id
	def update
		
	end
end