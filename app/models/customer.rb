class Customer < ActiveRecord::Base

  validates_presence_of :name, message: "Proszę podać imię."
  validates_presence_of :surname, message: "Proszę podać nazwisko."
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: "Nieprawidłowy adres e-mail." }, if: :email?
  validates :phone, format: { with: /[0-9]/, message: "Nieprawidłowe znaki." }
  validates :phone, length: { in: 6..9, message: "Nieprawidłowy nr telefonu." }, if: :phone?
  validate :email_or_phone_exist

  belongs_to :reservation


  private

    def email_or_phone_exist
      email.present? or phone.present? ? true : errors.add(:base, 'Prosze podać telefon lub e-mail.')
    end
end
