json.user do
  json.extract! user, :id, :name, :open_id
  json.image_url user.avatar.url
end
