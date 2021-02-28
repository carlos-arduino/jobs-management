class Company < ApplicationRecord
  has_many :jobs
  has_many :users
  has_one_attached :logo
  
  validates :domain, :name, presence: true
end
