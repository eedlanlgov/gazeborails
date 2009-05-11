class CreateTrendDatas < ActiveRecord::Migration
  def self.up
    create_table :trend_datas do |t|
      t.string :name
      t.string :value
      t.string :units

      t.timestamps
    end
  end

  def self.down
    drop_table :trend_datas
  end
end
