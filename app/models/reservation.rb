class Reservation < ActiveRecord::Base

  def as_json (options={}){ 
     :start => checkin,
     :end => checkout, 
     :title => "Rezerwacja"}
  end

  def self.disabled_days(made_reservations)
    reserved_days = []
    made_reservations.each do |reservation|
      num_of_days = (reservation.checkout - reservation.checkin).to_int
      day = reservation.checkin
      num_of_days.times do
        reserved_days << day.strftime('%-d-%m-%Y')
        day = day.next
      end
    end
    reserved_days.to_json.html_safe
  end

end
