class Reservation < ActiveRecord::Base

  validates_presence_of :checkin,  message: "Data początkowa nie może być pusta."
  validates_presence_of :checkout, message: "Data końcowa nie może być pusta."
  validate :correct_choosen_term
  validate :duration_of_reservation, if: :checkin? and :checkin?

  def as_json (options={}){ 
     :start => checkin,
     :end => (checkout + 1), 
     :title => "Rezerwacja"}
  end

private

  def correct_choosen_term
    # occupied_terms = Reservation.where("checkout > ?", DateTime.now)
    existing_reservations = Reservation.where("(checkin BETWEEN ? AND ?) AND (checkout BETWEEN ? AND ?)", checkin, checkout, checkin, checkout).count
    # binding.pry
    existing_reservations > 0 ? errors.add(:base, 'Termin zachodzi na inna rezerwacje.') : true
  end

  def duration_of_reservation
      number_of_days = checkout - checkin + 1
      number_of_days > 2 ? true : errors.add(:base, 'Minimum 3 dni.')
  end

end
