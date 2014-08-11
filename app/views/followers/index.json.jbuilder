json.array!(@followers) do |follower|
  json.extract! follower, :id, :user_id, :followed_by
  json.url follower_url(follower, format: :json)
end
