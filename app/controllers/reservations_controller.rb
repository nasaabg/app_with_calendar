class ReservationsController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :edit, :update, :destroy, :confirm, :cancel]
  before_action :set_reservation, only: [:show, :edit, :update, :destroy, :confirm, :cancel]
  respond_to :html, :json

  def confirm
    @reservation.confirm!
    redirect_to reservations_path
  end

  def cancel
    @reservation.cancel!
    redirect_to reservations_path
  end

  def booked_reservations
    @reservations = Reservation.all
    respond_with @reservations
  end
  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.order(created_at: :asc)
    respond_with @reservations
  end

  # GET /reservations/1
  # GET /reservations/1.json
  # def show
  # end

  # GET /reservations/new
  def new
    load_unavailable_dates
    @reservation = Reservation.new
    @reservation.build_customer
  end

  # GET /reservations/1/edit
  def edit
    load_unavailable_dates
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
  
    respond_to do |format|
      if @reservation.save
        ReservationMailer.reservation_details(@reservation).deliver
        format.html { redirect_to flat_path, notice: "Dziękujemy za wysłanie prośby o rezerwację. Skontaktujemy się z Toba w najbliższym czasie." }
        format.json { render :show, status: :created, location: @reservation }
      else
        load_unavailable_dates
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservations_url, notice: 'Rezerwacja została uaktualniona.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Rezerwacja została usunięta.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def reservation_params
    params.require(:reservation).permit(
      :checkin,
      :checkout,
      customer_attributes: [:name, :surname, :email, :phone]
    )
  end

  def load_unavailable_dates
    @unavailable_dates = Reservation::DisabledDays.new.call
  end
end

  

    