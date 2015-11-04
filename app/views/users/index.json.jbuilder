json.array!(@users) do |user|
  json.extract! user, :id, :userName, :password, :karma, :about
  json.url user_url(user, format: :json)
end
