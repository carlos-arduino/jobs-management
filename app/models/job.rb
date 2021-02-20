class Job < ApplicationRecord
  belongs_to :company
  has_many :enrollments
  has_many :candidates, through: :enrollments
  
  validates :title, :description, :level, :limit_date, :quantity , presence: true

  enum status: { ativo: 0, inativo: 5 }

  scope :available_status, -> { where(status: :ativo) }
  scope :available_status_and_not_expired, -> { available_status.where('limit_date >= ?', Date.current)}
  
end
