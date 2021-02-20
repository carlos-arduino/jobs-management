class Enrollment < ApplicationRecord
  belongs_to :candidate
  belongs_to :job

  enum status: { pendente: 0, aceito: 2, declinado: 5 }
end
