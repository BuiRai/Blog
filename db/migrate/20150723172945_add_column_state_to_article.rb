class AddColumnStateToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :state, :string
  end
end
