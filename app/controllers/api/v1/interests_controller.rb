class Api::V1::InterestsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  prepend_before_filter :authenticate_api_user!

  def index
    @religions = Religion.find_each.collect {|r| [r.id, r.name ]}
  end

end