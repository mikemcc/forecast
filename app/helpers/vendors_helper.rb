module VendorsHelper
  def select_vendors_for_item
    vendor_list = []
    vendor_list << ["Please select a vendor", "0"]
    vendors = Vendor.all
    vendors.each do | vendor |
      vendor_list << [vendor.name, vendor.id]
    end
    vendor_list
  end
end
