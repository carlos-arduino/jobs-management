class Proposal < ApplicationRecord
  belongs_to :enrollment

  validates :start_date, :salary_proposal, presence: true, on: :create
  validates :message_from_company, length: { minimum: 20 }, on: :create
  validates :reason, length: { minimum: 20 }, if: :candidate_declined?

  enum status: { pending: 0, accepted: 2, candidate_declined: 5 }
end
