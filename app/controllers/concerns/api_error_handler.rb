module ApiErrorHandler
  extend ActiveSupport::Concern

  def print_error(error_code, details, status)
    render json: {
      status: 'error',
      status_code: status,
      error: {
        code: error_code,
        message: I18n.t("api.errors.#{error_code}.title"),
        details: details,
        path: request.path,
        timestamp: Time.now
      }
    }, status: status
  end
end
