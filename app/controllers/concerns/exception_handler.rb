module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: {message: e.message}, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: {message: e.message}, status: :unprocessable_entity
    end

    rescue_from ActionController::ParameterMissing do |e|
      render json: {message: e.message}, status: :unprocessable_entity
    end

    rescue_from Timeout::Error do |e|
      render json: {message: e.message}, status: :request_timeout
    end
  end
end
