class Office < ActiveRecord::Base
  validates :name,  presence: true, length: { maximum: 140 }, uniqueness: { case_sensitive: false }
  validates :listed,  presence: true, numericality: { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1 }
  validates :status, numericality: { equal_to: 2 }, on: :create
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.zones_map(&:name) }
  validates_associated :providers, on: :create
  
  has_many :providers #, inverse_of: :office
  accepts_nested_attributes_for :providers
end
