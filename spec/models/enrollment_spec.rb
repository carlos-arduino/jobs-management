require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  context 'validation' do
    it { should belong_to(:job) }

    it { should belong_to(:candidate) }

    it { should have_one(:proposal) }

    it do
      should define_enum_for(:status).
        with_values(pending: 0, accepted: 2, candidate_refused: 4, declined: 5)
    end 
  end
end

