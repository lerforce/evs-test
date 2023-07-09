class ApplicationController < ActionController::API
  around_action :catch_exceptions

  def catch_exceptions
    yield
  rescue ActiveRecord::RecordNotFound => e
    render json: map_errors(e.message), status: 404
  rescue ArgumentError, ActionController::ParameterMissing => e
    render json: map_errors(e.message), status: 422
  rescue InvalidDateError => e
    render json: map_errors(e.message), status: InvalidDateError::STATUS_CODE
  end

  private

  def map_errors(errors)
    case errors
    when String
      { code: "error", message: errors }
    else
      errors.map { |k, m| { code: k.to_s, message: m } }
    end
  end

end
