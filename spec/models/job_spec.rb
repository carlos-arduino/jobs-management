require 'rails_helper'

describe Job do
  context 'validation' do
    it { should validate_presence_of(:title) }
    
    it { should validate_presence_of(:description) }

    it { should validate_presence_of(:level) }

    it { should validate_presence_of(:limit_date) }
    
    it { should validate_presence_of(:quantity) }

    it { should belong_to(:company) }

    it { should have_many(:enrollments) }
    
    it { should have_many(:candidates) }

    it do
      should define_enum_for(:status).
        with_values( active: 0, inactive: 5, filled: 10 )
    end
  end

  context 'status ativo by default' do
    it 'for new jobs created' do
      rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                       address: 'Rua Alameda Santos, 45',
                                       domain: 'rebase')
      job = Job.create!(title: 'Dev. Junior', description: 'Desenvolvedor ruby on rails',
                        income: '3000,00', level: 'Júnior', limit_date: '28/11/2021',
                        quantity: 5, company: rebase_company)

      expect(job.active?).to be_truthy
    end
  end
end
