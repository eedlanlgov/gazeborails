class AddUserIdToResult < ActiveRecord::Migration
  def self.up
    add_column :results, :user_id, :integer
  end

  def self.down
    remove_column :results, :user_id
  end
end
