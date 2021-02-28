require 'rails_helper'

describe Company do
  context 'validation' do
    it { should validate_presence_of(:domain) }
    
    it { should validate_presence_of(:name) }

    it { should have_many(:jobs) }
  end
end
