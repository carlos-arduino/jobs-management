class Job < ApplicationRecord
  belongs_to :company
  has_many :enrollments
  has_many :candidates, through: :enrollments

  after_touch :check_for_accepted_enrollments
  
  validates :title, :description, :level, :limit_date, :quantity , presence: true

  enum status: { active: 0, inactive: 5, filled: 10 }

  scope :active_and_not_expired, -> { active.where('limit_date >= ?', Date.current)}

  def enroll!(candidate)
    return false if self.candidates.exists?(candidate.id)
    Enrollment.create!(job: self, candidate: candidate)
  end

  def check_for_accepted_enrollments
    if self.enrollments.accepted.count == self.quantity
      self.filled!
    end
  end
  
end
