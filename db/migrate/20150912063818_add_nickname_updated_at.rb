class AddNicknameUpdatedAt < ActiveRecord::Migration
  def change
    add_column :users, :nickname_updated_at, :datetime
  end
end
