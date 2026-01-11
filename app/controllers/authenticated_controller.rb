class AuthenticatedController < ApplicationController
  before_action :authenticate_request!

  private

  def authenticate_request!
    header = request.headers["Authorization"]
    token = header.split(" ").last if header.present?
    return unauthorized! if token.blank?

    decoded = JwtService.decode(token)
    return unauthorized! if decoded.blank?
  end

  def unauthorized!
    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end