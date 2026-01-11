class AuthenticatedController < ApplicationController
  before_action :authenticate_user!

  private

  def authenticate_user!
    true
  end
end