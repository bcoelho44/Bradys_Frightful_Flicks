class User < ApplicationRecord
  # Devise modules for authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Relationships
  has_many :orders, dependent: :destroy
  has_one :address, dependent: :destroy

  # Validations
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  validates :role, inclusion: { in: ['customer'], message: "Only 'customer' role is allowed" }

  # Default role
  after_initialize :set_default_role, if: :new_record?

  # Scopes
  scope :customers, -> { where(role: 'customer') }

  # Methods
  def customer?
    role == 'customer'
  end

  private

  def set_default_role
    self.role ||= 'customer'
  end
end
