class ReservationsController < ApplicationController
    respond_to :html, :json

  def index
    @reservations = Reservation.all
    @reservation = Reservation.new
    @table = Reservation.disabled_days(Reservation.all)
    respond_with @reservations
  end

  def new
    @reservation = Reservation.new
    @table = Reservation.disabled_days(Reservation.all)
     # binding.pry
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
      params.require(:reservation).permit(:checkin, :checkout)
    end


end
