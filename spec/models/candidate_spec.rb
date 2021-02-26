require 'rails_helper'

describe Candidate do
  context 'validation' do
    it { should validate_presence_of(:email) }

    it { should validate_presence_of(:password) }
  end
end
