class WelcomeController < ApplicationController
	before_action :authenticate_admin!, only: [:dashboard]
  def index
  end

  #/Dashboard
  def dashboard
  	@articles = Article.all
  end
end
