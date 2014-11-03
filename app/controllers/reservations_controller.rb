class ReservationsController < ApplicationController
    respond_to :html, :json

  def index
    load_reservations
    respond_with @reservations
  end

  def new
    load_unavailable_dates
    build_reservation
  end

  def create
    build_reservation
    save_reservation or (load_unavailable_dates and render 'new')
  end

private

    def load_reservations
      @reservations = reservation_scope
    end

    def load_reservation
      @reservation = reservation_scope.find_by_id(params[:id])
    end

    def build_reservation
      @reservation = reservation_scope.build(reservation_params)
    end

    def save_reservation
      if @reservation.save
        redirect_to reservations_path
      end
    end

    def reservation_params
      reservation_params = params[:reservation]
      reservation_params ? params.require(:reservation).permit(:checkin, :checkout) : {}
    end

    def reservation_scope
      Reservation.all
    end

    def load_unavailable_dates
      @unavailable_dates = Reservation::DisabledDays.new.call
    end


end
