class Candidate < ApplicationRecord
  has_many :enrollments
  has_many :jobs, through: :enrollments
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
