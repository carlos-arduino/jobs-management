class Company < ApplicationRecord
  has_many :jobs
  validates_associated :jobs

  validates :domain, :name, :address, presence: true
end
