class Job < ApplicationRecord
  belongs_to :company
  has_many :enrollments
  has_many :candidates, through: :enrollments
  
  validates :title, :description, :level, :limit_date, :quantity , presence: true

  enum status: { active: 0, inactive: 5 }

  scope :active_and_not_expired, -> { active.where('limit_date >= ?', Date.current)}

  def enroll!(candidate)
    return false if self.candidates.exists?(candidate.id)
    Enrollment.create!(job: self, candidate: candidate)
  end
  
end
