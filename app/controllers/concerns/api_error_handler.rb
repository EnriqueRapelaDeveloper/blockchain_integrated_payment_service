module ApiErrorHandler
  extend ActiveSupport::Concern

  def print_error(error_code, details, status, value = nil)
    render json: {
      status: 'error',
      status_code: status,
      error: {
        code: error_code,
        message: I18n.t("api.errors.#{error_code}.title", value: value),
        details: details,
        path: request.path,
        timestamp: Time.now,
        suggestion: I18n.t("api.errors.#{error_code}.suggestion"),
      }
    }, status: status
  end

  def print_multiple_errors(error_code, status, errors, value = nil)
    error_response = generate_error_response

    errors.each do |error|
      error_response[:errors].push({
        code: error_code,
        message: error.full_message,
        path: request.path,
        timestamp: Time.now,
        suggestion: I18n.t("api.errors.#{error_code}.suggestion")
      })
    end

    render json: error_response, status: status
  end

  private

  def generate_error_response
    {
      status: 'error',
      status_code: status,
      errors: []
    }
  end
end
