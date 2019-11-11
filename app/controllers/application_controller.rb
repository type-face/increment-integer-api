# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :check_media_type unless devise_controller?
  before_action :set_headers

  def check_media_type
    raise ActionController::UnknownFormat, 'unsupported media type' unless
      request.content_type == 'application/vnd.api+json'
  end

  def set_headers
    response.headers['Content-Type'] = 'application/vnd.api+json'
  end
end
