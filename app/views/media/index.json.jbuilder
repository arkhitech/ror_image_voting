json.array!(@media) do |medium|
  json.extract! medium, :id, :picture, :caption, :is_private, :user_id
  json.url medium_url(medium, format: :json)
end
