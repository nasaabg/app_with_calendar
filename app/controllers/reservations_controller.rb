class ReservationsController < ApplicationController
    respond_to :html, :json

  def index
    @reservations = Reservation.all
    respond_with @reservations
  end

  def new
    load_unavailable_dates
    build_reservation
    build_customer
  end

  def create
    build_reservation
    save_reservation or (load_unavailable_dates and render 'new')
  end

private

    def reservation_scope
      Reservation.all
    end

    def load_reservations
      @reservations = Reservation.all
    end

    def load_reservation
      @reservation = Reservation.find_by_id(params[:id])
    end

    def build_reservation
      @reservation = Reservation.new(reservation_params)
    end

    def build_customer
      @reservation.build_customer
    end

    def save_reservation
      if @reservation.save
        ReservationMailer.reservation_details(@reservation).deliver
        flash[:notice] = "Dziękujemy za wysłanie prośby o rezerwację. Skontaktujemy się z Toba w najbliższym czasie."
        redirect_to flat_path
      end
    end

    def reservation_params
      reservation_params = params[:reservation]
      reservation_params ? params.require(:reservation).permit(:checkin, :checkout,
       customer_attributes: [:name, :surname, :email, :phone]) : {}
    end

    def load_unavailable_dates
      @unavailable_dates = Reservation::DisabledDays.new.call
    end


end
