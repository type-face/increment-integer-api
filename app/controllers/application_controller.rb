# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from ActionController::UnknownFormat, with: :unsupported_media_type

  before_action :check_media_type
  before_action :set_headers

  def check_media_type
    raise ActionController::UnknownFormat, 'unsupported media type' unless
      request.content_type == 'application/vnd.api+json'
  end

  def unsupported_media_type
    render body: nil, status: :unsupported_media_type, head: :no_content
  end

  def set_headers
    response.headers['Content-Type'] = 'application/vnd.api+json'
  end

  def render_errors(object)
    render json: { errors: ErrorSerializer.serialize(object) }, status: :unprocessable_entity
  end
end
