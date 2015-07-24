class ArticlesController < ApplicationController
	#Before, verify if a user is logged, this is from device
	before_action :authenticate_user!, except: [:show,:index]

	before_action :set_article, except: [:index, :new, :create]
	before_action :authenticate_editor!, only: [:new, :create, :update]
	before_action :authenticate_admin!, only: [:destroy, :publish]

	#GET /articles
	def index
		#all the registers from the DB
		#@articles = Article.publicados.ultimos

		#paginate is from the gem "will_paginate"
		@articles = Article.paginate(page: params[:page], per_page:5).publicados.ultimos
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

	#Method to publish an article, must change the stage of 
	#the article and then, redirect to the article
	def publish
		@article.publish!
		redirect_to @article
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