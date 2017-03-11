class AddAttachToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :attach, :boolean, default: false
  end
end
