# frozen_string_literal: true

class Allocation < ApplicationRecord
  belongs_to :driver, class_name: 'User', foreign_key: 'driver_id', optional: true
  belongs_to :passenger, class_name: 'User', foreign_key: 'passenger_id'

  enum status: %i[waiting allocated]

  validates_presence_of :address
  validates_length_of :address, maximum: 100, allow_nil: true, allow_blank: false

  before_save :validate_passenger
  before_update :validate_driver

  def validate_passenger
    unless passenger.passenger?
      errors.add(:passenger, invalid: I18n.t('allocation.errors.invalid_passenger'))
      throw :abort
    end
  end

  def validate_driver
    unless driver.driver?
      errors.add(:driver, invalid: I18n.t('allocation.errors.invalid_driver'))
      throw :abort
    end
  end

  def allocated?
    status == 'allocated' && driver.nil?
  end
end
