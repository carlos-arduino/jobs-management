class Job < ApplicationRecord
  belongs_to :company
  has_many :enrollments
  has_many :candidates, through: :enrollments
  
  validates :title, :description, :level, :limit_date, :quantity , presence: true

  enum status: { active: 0, inactive: 5 }

  scope :available_status, -> { where(status: :active) }
  scope :available_status_and_not_expired, -> { available_status.where('limit_date >= ?', Date.current)}

  def enroll!(candidate)
    return false if self.candidates.exists?(candidate.id)
    Enrollment.create!(job: self, candidate: candidate)
  end
  
end
