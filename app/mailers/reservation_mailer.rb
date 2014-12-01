class ReservationMailer < ActionMailer::Base
  default from: "Strona Rezerwacji"

  def reservation_details(reservation)
    @reservation = reservation
    @customer = @reservation.customer
    mail(to: "janek.kurzydlo@gmail.com", subject: "Dokonano rezerwacji")
  end
end
