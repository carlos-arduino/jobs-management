class Enrollment < ApplicationRecord
  belongs_to :candidate
  belongs_to :job
  has_one :proposal

  validates :reason, length: { minimum: 20 }, if: :declined?

  enum status: { pending: 0, accepted: 2, candidate_refused: 4, declined: 5 }
end
