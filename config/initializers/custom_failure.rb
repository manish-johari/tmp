class CustomFailureApp < Devise::FailureApp
  def respond
    if request.format == 'application/json'
      json_failure
    else
      super
    end
  end

  def json_failure
    self.status = 401
    self.content_type = 'json'
    self.response_body = "{\"errors\" : \"#{I18n.t(:invalid)}\"}"
  end
end
