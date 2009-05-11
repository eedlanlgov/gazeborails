class CreateResultSegmentJoinTable < ActiveRecord::Migration
  def self.up
    create_table :results_segments, :id => false do |t|
      t.integer :result_id
      t.integer :segment_id 
    end
  end

  def self.down
    drop_table :results_segments
  end
end
