class ArticleMailer < ApplicationMailer
	def new_article(article)
		@article = article
		User.all.each do |user|
			mail(to: user.email, subject: "Nuevo artículo en el blog de Anime")
		end
	end
end
