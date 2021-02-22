class Enrollment < ApplicationRecord
  belongs_to :candidate
  belongs_to :job
  has_one :proposal

  validates :reason, length: { minimum: 20 } 

  enum status: { pendente: 0, aceito: 2, declinado: 5 }
end
