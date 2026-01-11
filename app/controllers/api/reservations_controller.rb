class Api::ReservationsController < ApplicationController

  def create
    render json: { message: "Reservation created successfully" }, status: :created
  end
end
