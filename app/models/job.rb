class Job < ApplicationRecord
  validates :title, :description, :level, :limit_date, :quantity , presence: true
  
  belongs_to :company
end
