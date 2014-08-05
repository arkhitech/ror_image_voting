json.array!(@slams) do |slam|
  json.extract! slam, :id, :media_id_first_id, :media_id_second_id
  json.url slam_url(slam, format: :json)
end
