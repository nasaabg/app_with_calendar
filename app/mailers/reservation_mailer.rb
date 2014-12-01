class ReservationMailer < ActionMailer::Base
  default from: "from@example.com"

  def reservation_details(reservation)
    @reservation = reservation
    @customer = @reservation.customer
    mail(to: "nasaabg@interia.pl", subject: "Dokonano rezerwacji")
  end
end
