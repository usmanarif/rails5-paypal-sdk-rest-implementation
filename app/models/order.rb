class Order < ApplicationRecord
	belongs_to :product
	attr_accessor :card_number, :card_verification, :address, :city, :state, :postal_code, :expire_month, :expire_year

	scope :completed, -> { where(status: 'completed')}
end
