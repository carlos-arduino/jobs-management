class Job < ApplicationRecord
  belongs_to :company
  
  validates :title, :description, :level, :limit_date, :quantity , presence: true

  enum status: { ativo: 0, inativo: 5 }
  
end
