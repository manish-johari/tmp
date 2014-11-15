class Api::V1::MyinterestsController < ApplicationController
skip_before_filter :verify_authenticity_token
prepend_before_filter :authenticate_api_user!

  def index
    user_interests = User.first.myinterests
    all_interests=["Religion", "Pets"]
    result = Hash.new
    all_interests.each do |interest|
    result.merge! ({ interest => user_interests.where("selectable_type"=> interest).ids })
    end
    @result = result
  end


end