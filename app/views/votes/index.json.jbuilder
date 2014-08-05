json.array!(@votes) do |vote|
  json.extract! vote, :id, :vote_status, :user_id_id, :slam_id_id
  json.url vote_url(vote, format: :json)
end
