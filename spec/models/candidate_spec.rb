require 'rails_helper'

describe Candidate do
  context 'validation' do
    it { should validate_presence_of(:email) }

    it { should validate_presence_of(:password) }

    it { should validate_presence_of(:full_name) }

    it { should validate_presence_of(:birth_date) }

    it { should have_many(:enrollments) }

    it { should have_many(:jobs) }
  end
end
