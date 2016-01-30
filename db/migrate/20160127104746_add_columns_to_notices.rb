class AddColumnsToNotices < ActiveRecord::Migration
  def change
    add_column :notices, :body, :text
    add_column :notices, :new,  :boolean, default: true
  end
end
