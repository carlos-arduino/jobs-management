class Enrollment < ApplicationRecord
  belongs_to :candidate
  belongs_to :job

  enum status: { pendente: 0, declinado: 5 }
end
