json.array!(@payloads) do |payload|
  json.extract! payload, :id, :contents, :user_id
  json.url payload_url(payload, format: :json)
end
