# frozen_string_literal: true

module V1
  class IncrementerController < ApplicationController
    before_action :authenticate_user!

    def show
      render json: UserSerializer.new(current_user).serialized_json, status: :ok
    end

    def increment
      if current_user.update(incrementer: current_user.incrementer + 1)
        render json: UserSerializer.new(current_user).serialized_json, status: :ok
      else
        render json: {}, status: 500
      end
    end

    def update
      return unless authorize_user_params

      if current_user.update(incrementer: permitted_params['attributes']['incrementer'])
        render json: UserSerializer.new(current_user).serialized_json, status: :ok
      else
        render json: { errors: ErrorsSerializer.serialize(current_user) }, status: :unprocessable_entity
      end
    end

    private

    def permitted_params
      params.require(:data).permit(:id, :type, attributes: :incrementer)
    end

    def authorize_user_params
      if current_user.id != permitted_params['id'] || permitted_params['type'].downcase != 'user'
        render_authenticate_error
        return false
      end
      true
    end
  end
end
