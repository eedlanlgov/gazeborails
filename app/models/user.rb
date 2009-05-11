class User < ActiveRecord::Base
	
  has_many :results
  has_and_belongs_to_many :segments
  validates_presence_of  :name, :pw
  validates_uniqueness_of :name
  
  def self.authenticate(name, password)
  	user = self.find_by_name(name)
  	if user
  		if user.password != password
  			user = nil
  		end
  	end
  	user			
  end
  
  def password
  	@password
  end
  	
  
end
