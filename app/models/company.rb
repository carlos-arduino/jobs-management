class Company < ApplicationRecord
  validates :domain, :name, :address, presence: true
  has_many :job

end
