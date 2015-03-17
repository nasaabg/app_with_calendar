class Reservation < ActiveRecord::Base

  # after_save :send_reservation_details

  validates_presence_of :checkin,  message: "Data początkowa nie może być pusta."
  validates_presence_of :checkout, message: "Data końcowa nie może być pusta."
  validate :correct_choosen_term
  validate :duration_of_reservation, if: :checkin? and :checkout?

  has_one :customer, dependent: :destroy
  accepts_nested_attributes_for :customer

  def as_json (options={}){ 
     :start => checkin,
     :end => (checkout + 1), 
     :title => "Rezerwacja"}
  end

  # def send_reservation_details
  #   ReservationMailer.reservation_details(self).deliver
  # end

  def correct_choosen_term
    reserved = 
      Reservation.where(
        '(checkin <= ? AND checkout >= ?) OR (checkin >= ? AND checkin <= ?)',
        checkin,
        checkin,
        checkin,
        checkout
      )

    errors.add(:base, 'Termin zachodzi na inna rezerwacje.') unless reserved.empty?
    
  end

  def duration_of_reservation
      number_of_days = checkout - checkin + 1
      number_of_days > 2 ? true : errors.add(:base, 'Minimum 3 dni.')
  end

end
