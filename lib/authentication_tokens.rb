class AuthenticationTokens
  include Singleton

  # generate authentication token
  # the generated token will be stored in db with the associated user.
  def generate(user_id)
    # generate token as devise generates the token
    token = friendly_token
    store_token user_id, token
    token
  end

  # Generate a friendly string randomly to be used as token.
  def friendly_token
     SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
  end

  # Returns the token value i.e. user_id to which the token belongs
  def token_val(token)
    user_token = UserAuthenticationToken.find_by_token token
    if user_token.blank? || user_token.updated_at <= (Time.now - 1.day).utc
      # expire the 1 day before token
      user_token.delete unless user_token.blank?
      return nil
    else
      # To update the updated_at column.
      user_token.touch
      user_token.user_id
    end
  end

  # Store the token with user_id
  def store_token(user_id, token)
    UserAuthenticationToken.create(:user_id => user_id, :token => token)
  end
end