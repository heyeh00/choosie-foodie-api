class Api::V1::BaseController < ActionController::Base
  HMAC_SECRET = Rails.application.credentials.dig(:jwt, :hmac_secret) # find the secret

  skip_before_action :verify_authenticity_token
end
