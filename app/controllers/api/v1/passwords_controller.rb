class Api::V1::PasswordsController < Devise::PasswordsController
  skip_before_filter :verify_authenticity_token, :only => [:create, :update]
  prepend_before_filter :authenticate_api_user!

  def create
    self.resource = resource_class.send_reset_password_instructions(params[resource_name])

    respond_to do |format|
      if resource.errors.empty?
        set_flash_message(:notice, :send_instructions) if is_navigational_format?
        format.json{render :json => {:success => true, :status => t(:password_reset_mail_sent)} and return}
      else
        format.json {render :json => {:errors => true, :status => t(:email_not_associated_with_account)} and return}
      end
    end

  end

  def update
    respond_to do |format|
      if params[:user][:password].blank?
        format.html{
         super
        }
        format.json {render :json => {:errors => true, :status => t(:password_cannot_blank)}}
      else
        format.html{super}
        format.json{
          self.resource = resource_class.reset_password_by_token(params[resource_name])
          
          if resource.errors.empty?
            # resource.unlock_access! if unlockable?(resource)
            # resource.reset_flag = true
            resource.save
            # user = resource.user_info
            
            render :json => {:success => true, :user => resource} and return
          else
            render :json => {:errors => true, :status => t(:reset_password_token_not_valid)}
          end
        }
      end
    end
  end

end