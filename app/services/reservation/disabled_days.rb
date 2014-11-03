class Reservation::DisabledDays

  attr_reader :done_reservations

  def initialize
    @done_reservations = Reservation.where("checkout > ?", DateTime.now)
    @disabled_days = [] 
  end

  def call
    @done_reservations.each do |reservation|
      num_of_days = (reservation.checkout - reservation.checkin).to_int + 1
      day = reservation.checkin
      num_of_days.times do
        @disabled_days << day.strftime('%-d-%m-%Y')
        day = day.next
      end
    end
    @disabled_days.to_json.html_safe    
  end


end