class CreateNodeResultJoinTable < ActiveRecord::Migration
  def self.up
    create_table :nodes_results, :id => false do |t|
      t.integer :node_id
      t.integer :result_id 
    end
  end

  def self.down
    drop_table :nodes_results
  end
end
