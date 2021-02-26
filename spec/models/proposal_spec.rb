require 'rails_helper'

describe Proposal do
  context 'validation' do
    it { should validate_presence_of(:start_date) }
    
    it { should validate_presence_of(:salary_proposal) }

  end
end
