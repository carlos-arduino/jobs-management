class Company < ApplicationRecord
  has_many :jobs
  
  validates :domain, :name, :address, presence: true
end
