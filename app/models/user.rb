class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true, allow_blank: true, allow_nil: true, format: URI::MailTo::EMAIL_REGEXP
  validates :phone, presence: true, uniqueness: true, format: { with: /\A\(\d{2,}\) \d{5}-\d{4}\z/ }

  # the authenticate method from devise documentation
  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

  def email_required?
    false
  end

  def password_required?
    false
  end
end
