class Sheet < ActiveRecord::Base
	belongs_to :user
	has_many :items

	def self.csv_header
    #Using ruby's built-in CSV::Row class
    #true - means its a header
    CSV::Row.new(
			[:vendor_name,
				:jan, :feb, :mar,
				:apr, :may, :jun,
				:jul, :aug, :sep,
				:oct, :nov, :dec,
				:item_id, :sheet_id, :vendor_id, :signature],
		['Vendor Name',
			'Jan', 'Feb','Mar',
			'Apr', 'May', 'Jun',
			'Jul', 'Aug', 'Sep',
			'Oct', 'Nov', 'Dec',
			'Item ID', 'Sheet ID', 'Vendor ID', 'Signature'],
		true)
  end

  def to_csv_row(item)
    CSV::Row.new(
			[:vendor_name,
				:jan, :feb, :mar,
				:apr, :may, :jun,
				:jul, :aug, :sep,
				:oct, :nov, :dec,
				:item_id, :sheet_id, :vendor_id, :signature],
			[item.vendor.name,
				item.january,
				item.february,
				item.march,
				item.april,
				item.may,
				item.june,
				item.july,
				item.august,
				item.september,
				item.october,
				item.november,
				item.december,
				item.id, item.sheet_id, item.vendor_id, item.signature]
		)
  end

end
