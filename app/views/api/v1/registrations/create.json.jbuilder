if @resource_saved
  json.user_id resource.id
  json.is_confirmed @user.confirmed?
  json.auth_token @auth_token
else
  json.errors do
    json.email resource.errors.full_messages.join(', ')
    json.errors resource.errors.full_messages.join(', ')
  end
end