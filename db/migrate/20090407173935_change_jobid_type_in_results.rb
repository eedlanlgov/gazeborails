class ChangeJobidTypeInResults < ActiveRecord::Migration
  def self.up
    remove_column :results, :jobid
    add_column :results, :jobid, :integer
  end

  def self.down
    remove_column :results, :jobid
    add_column :results, :jobid, :string
  end
end
