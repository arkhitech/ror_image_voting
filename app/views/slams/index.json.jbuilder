json.array!(@slams) do |slam|
  json.extract! slam, :id, :medium_first_id, :medium_second_id
  json.url slam_url(slam, format: :json)
end
