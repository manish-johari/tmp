if @sent
  json.message "ok"
elsif @user.confirmed?
  json.errors do
    json.errors "User is already confirmed"
  end
else
  json.errors do
    json.errors t(:error)
  end
end
