class ApplicationController < ActionController::API
  include RackSessionFix
  include ApiErrorHandler
end
