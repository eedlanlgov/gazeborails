class Chart < ActiveRecord::Base
	has_one :user
	has_one :tn
	has_one :type
end
