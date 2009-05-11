class Trend_data < ActiveRecord::Base
  belongs_to :result
  validates_presence_of :name, :value, :result_id
end

class TrendData < ActiveRecord::Base
  belongs_to :result
  validates_presence_of :name, :value, :result_id
end