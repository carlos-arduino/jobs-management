require 'rails_helper'

describe Job do
  context 'validation' do
    it { should validate_presence_of(:title) }
    
    it { should validate_presence_of(:description) }

    it { should validate_presence_of(:level) }

    it { should validate_presence_of(:limit_date) }
    
    it { should validate_presence_of(:quantity) }
  end

end
