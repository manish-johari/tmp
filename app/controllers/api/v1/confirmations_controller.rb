class Api::V1::ConfirmationsController < Devise::ConfirmationsController
  skip_before_filter :verify_authenticity_token
  prepend_before_filter :authenticate_api_user!

  def create
    @user = resource_class.send_confirmation_instructions(resource_params)
    @sent = successfully_sent?(@user)
    if @sent
      render status: 200
    elsif @user.confirmed?
      render status: 422
    else
      render status: 400
    end
  end

  def confirm_token
    @user = User.confirm_by_token params[:confirmation_token]
    if @user.errors.present? 
      render status: 422 
    else
      render status: 200
    end
  end
  
end