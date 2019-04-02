class User < ApplicationRecord
  has_secure_password

  has_many :allocations

  validates_uniqueness_of :email, message: { in_use: I18n.t('user.errors.email_taken') }
  validates_presence_of :email

  validates_length_of :password, maximum: 72, allow_nil: true, allow_blank: false
  validates_confirmation_of :password, allow_nil: true, allow_blank: false

  validates_presence_of :role
  validates :role,
            inclusion: { in: %w[driver passenger],
                         message: { invalid: I18n.t('user.errors.invalid_role') } },
            allow_nil: true,
            allow_blank: false

  def passenger?
    role == 'passenger'
  end

  def driver?
    role == 'driver'
  end
end
