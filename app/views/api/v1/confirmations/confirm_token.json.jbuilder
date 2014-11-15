if @user.errors.present?
 json.errors do
  json.confirmation_token @user.errors.full_messages.join(', ')
  json.errors @user.errors.full_messages.join(', ')
 end
else
  json.message "ok"
  json.user_id @user.id
  json.is_confirmed @user.confirmed?
end
