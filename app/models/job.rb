class Job < ApplicationRecord
  belongs_to :company
  
  validates :title, :description, :level, :limit_date, :quantity , presence: true
  
end
