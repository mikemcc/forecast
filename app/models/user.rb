class User < ActiveRecord::Base
	has_many :sheets
	has_many :items
	has_many :vendors, through: :items
	has_one :payload	
end
