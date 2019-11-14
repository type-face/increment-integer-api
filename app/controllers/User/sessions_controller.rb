# frozen_string_literal: true

class User
  class SessionsController < DeviseTokenAuth::SessionsController
    def render_create_success
      render json: UserSerializer.new(current_user).serialized_json, status: :created
    end
  end
end
