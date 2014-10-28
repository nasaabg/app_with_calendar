class ReservationsController < ApplicationController
    respond_to :html, :json

  def index
    @reservations = Reservation.all
    respond_with @reservations
  end


end
