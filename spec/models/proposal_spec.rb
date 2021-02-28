require 'rails_helper'

describe Proposal do
  context 'validation' do
    it { should validate_presence_of(:start_date) }
    
    it { should validate_presence_of(:salary_proposal) }

    it { should belong_to(:enrollment) }

    it { should validate_length_of(:message_from_company).is_at_least(20).on(:create) }

    it do
      should define_enum_for(:status).
        with_values(pending: 0, accepted: 2, candidate_declined: 5 )
    end

    it 'with reason length less than 20 caracteres' do
      rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                      address: 'Rua Alameda Santos, 45',
                                      domain: 'rebase')
      rebase_job = Job.create!(title: 'Dev. Junior', 
                               description: 'Desenvolvedor ruby on rails',
                               income: '3000,00', level: 'Júnior', 
                               limit_date: Date.current + 1.day,
                               quantity: 5, company: rebase_company)
      candidate = Candidate.create!(email: 'cae@gmail.com', password: '123456',
                                    full_name: 'Carlos Arduino',
                                    birth_date: '25/11/1983')
      enrollment = Enrollment.create!(job: rebase_job, candidate: candidate)

      proposal = Proposal.new(message_from_company: 'Disponibilidade para início imediato?',
                              start_date: Date.current,
                              salary_proposal: '3000,00',
                              reason: 'XXXXXXXX',
                              status: :candidate_declined,
                              enrollment: enrollment)

      expect(proposal.valid?).to eq(false)
    end
  end
end
