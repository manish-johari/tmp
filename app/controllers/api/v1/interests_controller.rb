class Api::V1::InterestsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @religions = Religion.find_each.collect {|r| [r.id, r.name ]}
  end

end