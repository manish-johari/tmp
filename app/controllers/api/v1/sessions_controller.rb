class Api::V1::SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token, :only => [:create, :destroy]

  def create
    if params[:provider] == 'facebook'
      user = User.from_omniauth(fb_data, current_user)
      sign_in(user) if user.persisted?
      self.resource = user
    else
      self.resource = warden.authenticate!(auth_options)
    end

    # generate new auth_token
    @auth_token = AuthenticationTokens.instance.generate resource.id
  end

  def destroy
    token = UserAuthenticationToken.find_by(token: params[:auth_token]) if params[:auth_token]
    token.delete unless token.blank?
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
  end

  private

  def fb_data
    auth = {"provider"=>"#{params["provider"]}",
            "uid"=>"#{params["fb_user_id"]}",
            "token"=>"#{params["fb_access_token"]}",
            }
    return auth
  end

end
