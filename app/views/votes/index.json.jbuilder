json.array!(@votes) do |vote|
  json.extract! vote, :id, :vote_status, :user_id, :slam_id
  json.url vote_url(vote, format: :json)
end
