class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.string :name
      t.boolean :result
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
