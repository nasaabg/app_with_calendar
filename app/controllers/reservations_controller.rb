class ReservationsController < ApplicationController
    respond_to :html, :json

  def index
    @reservations = Reservation.all
    respond_with @reservations
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to reservations_path
    else
      render 'new'
    end

  end

  private

    def reservation_params
      params.require(:reservation).permit(:start, :end)
    end


end
