require 'rails_helper'

describe Company do
  context 'validation' do
    it { should validate_presence_of(:domain) }
    
    it { should validate_presence_of(:name) }
  end
end
