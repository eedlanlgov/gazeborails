class Result < ActiveRecord::Base
  belongs_to :user
  has_many :trend_datas, :dependent => :destroy
  has_and_belongs_to_many :segments
  has_and_belongs_to_many :nodes

  validates_presence_of :name, :result, :start, :end, :user_id, :jobid, :duration, :numprocs
end
