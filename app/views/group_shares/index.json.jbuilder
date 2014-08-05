json.array!(@group_shares) do |group_share|
  json.extract! group_share, :id, :group_id, :media_id
  json.url group_share_url(group_share, format: :json)
end
