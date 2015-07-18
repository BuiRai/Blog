class ArticlesController < ApplicationController
	
	#GET /articles
	def index
		@articles = Article.all #all the registers from the DB
	end

	#GET /articles/:id
	def show
		#Find one register by Id
		@article = Article.find(params[:id]);
	end

	#GET /articles/new
	def new
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id]);
	end

	#POST /articles
	def create
		#First create the article with params
		@article = Article.new(article_params)
		
		if @article.save  #save the articles on the DataBase
			redirect_to @article #Redirect to /articles/:id
		else
			render :new #render of the action new
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy #Delete the object from the DB
		redirect_to articles_path
	end

	#PUT /articles/:id
	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to @article
		else
			render :edit
		end
	end

	private
	def article_params
		params.require(:article).permit(:title,:body)
	end
end