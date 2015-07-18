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
end