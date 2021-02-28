class Candidate < ApplicationRecord
  has_many :enrollments
  has_many :jobs, through: :enrollments
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, :birth_date, presence: true
end
