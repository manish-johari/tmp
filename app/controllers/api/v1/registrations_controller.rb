class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token

  def new
    super
  end

  def create
    build_resource(sign_up_params)
    @resource_saved = resource.save
    if @resource_saved
      render status: 201
    else
      render status: 409
    end
  end

end