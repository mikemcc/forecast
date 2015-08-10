require 'digest/sha1'

class Item < ActiveRecord::Base
	belongs_to :user
	belongs_to :vendor
	belongs_to :sheet

	validates :vendor, presence: true
	validates :user,   presence: true
	validates :sheet,  presence: true

  # create an SHA1-signed hash of user id, vendor id, and vendor name
	def sign
    user_id = self.id
		vendor_id = self.vendor.id
		vendor_name = self.vendor.name

		rawtext = "#{user_id}#{vendor_id}#{vendor_name}"
		rawtext.to_sha1
	end #def

  # can be called by any other object
  def self.sign(user_id, vendor_id, vendor_name)
		rawtext = "#{user_id}#{vendor_id}#{vendor_name}"
		rawtext.to_sha1
	end

end
