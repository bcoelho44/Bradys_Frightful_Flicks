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
  validates :role, presence: true, inclusion: { in: %w[admin customer], message: "%{value} is not a valid role" }

  # Scopes
  scope :admins, -> { where(role: 'admin') }
  scope :customers, -> { where(role: 'customer') }

  # Callbacks
  after_initialize :set_default_role, if: :new_record?

  # Methods
  def admin?
    role == 'admin'
  end

  def customer?
    role == 'customer'
  end

  private

  def set_default_role
    self.role ||= 'customer'
  end
end
