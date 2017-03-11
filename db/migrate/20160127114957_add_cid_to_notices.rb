class AddCidToNotices < ActiveRecord::Migration
  def change
    add_column :notices, :cid, :integer
  end
end
