module Api
  class BaseApiController < ApplicationController
    respond_to :json

    include ActionController::Serialization

    before_action :verify_requested_format!

    def errors_msg(obj = nil)
      object_resource = obj || resource
      render json: { errors: object_resource.errors.full_messages.to_sentence }, status: :bad_request
    end

    def record_not_found_v1(model)
      render json: { errors: "#{model.name.titleize} not found!" }, status: :bad_request
    end

    def custom_errors(message)
      render json: { errors: message }, status: :bad_request
    end
  end
end
