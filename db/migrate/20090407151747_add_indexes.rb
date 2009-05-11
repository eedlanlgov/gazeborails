class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :results, :name
    add_index :trend_datas, :name
  end

  def self.down
    remove_index :results, :name
    remove_index :trend_datas, :name
  end
end
