class AddResultIdToTrendData < ActiveRecord::Migration
  def self.up
    add_column :trend_datas, :result_id, :integer
  end

  def self.down
    remove_column :trend_datas, :result_id
  end
end
