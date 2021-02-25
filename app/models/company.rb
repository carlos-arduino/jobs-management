class Company < ApplicationRecord
  has_many :jobs
  has_many :users
  
  validates :domain, :name, presence: true
end
