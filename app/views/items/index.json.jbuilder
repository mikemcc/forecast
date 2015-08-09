json.array!(@items) do |item|
  json.extract! item, :id, :name, :user_id, :vendor_id, :sheet_id, :version, :signature, :january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december
  json.url item_url(item, format: :json)
end
