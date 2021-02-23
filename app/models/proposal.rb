class Proposal < ApplicationRecord
  belongs_to :enrollment

  validates :start_date, :salary_proposal, presence: true
  validates :message_from_company, length: { minimum: 20 }

  enum status: { pendente: 0, aceito: 2, declinado: 5 }
end
