class Sheet < ActiveRecord::Base
	belongs_to :user
	has_many :items

	def self.csv_header
    #Using ruby's built-in CSV::Row class
    #true - means its a header
    CSV::Row.new([:user_id, :vendor_id, :vendor_name, :signature],
		['User ID', 'Vendor ID', 'Vendor Name', 'Signature'],
		true)
  end

  def to_csv_row(item)
    CSV::Row.new(
			[:user_id, :vendor_id, :vendor_name, :signature],
			[item.user_id, item.vendor_id, item.vendor.name, item.signature]
		)
  end

  def self.find_in_batches(filters, batch_size, &block)
    #find_each will batch the results instead of getting all in one go
    where(filters).find_each(batch_size: batch_size) do |transaction|
      yield transaction
    end
  end

end
