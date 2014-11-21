class Customer < ActiveRecord::Base

  validates_presence_of :name, message: "Proszę podać imię."
  validates_presence_of :surname, message: "Proszę podać nazwisko."
  validate :email_or_phone

  belongs_to :reservation


  private
    def email_or_phone
      email.present? or phone.present? ? true : errors.add(:base, 'Prosze podać telefon lub e-mail.')
    end
end
