class AddColumnRandidToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :randid, :string
  end
end
