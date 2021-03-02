require 'rails_helper'

feature 'Candidate can decline proposal' do
    scenario 'and view link for decline' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        job_rebase = Job.create!(title: 'Dev. Júnior', 
                                 description: 'Desenvolvedor ruby on rails',
                                 income: '3000,00', level: 'Júnior', 
                                 limit_date: Date.current + 1.day,
                                 quantity: 5, company: rebase_company)
        candidate_cleber = Candidate.create!(email: 'cleber@gmail.com', 
                                             password: '222222', 
                                             full_name: 'Cleber Feltrin',
                                             birth_date: '22/01/1983')
        cleber_enrollment = Enrollment.create!(job: job_rebase, candidate: candidate_cleber)
        proposal_to_cleber = Proposal.create!(message_from_company: 'Teria disponibilidade para início imediato',
                                              start_date: Date.current,
                                              salary_proposal: '3500,00',
                                              enrollment: cleber_enrollment)
        
        login_as candidate_cleber, scope: :candidate
        visit enrollments_path
        page.find("#enrollment-#{cleber_enrollment.id}").click_on 'Você tem uma proposta para esta vaga'

        expect(page).to have_link('Recusar')
    end

    scenario 'and view form to justify' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        job_rebase = Job.create!(title: 'Dev. Júnior', 
                                 description: 'Desenvolvedor ruby on rails',
                                 income: '3000,00', level: 'Júnior', 
                                 limit_date: Date.current + 1.day,
                                 quantity: 5, company: rebase_company)
        candidate_cleber = Candidate.create!(email: 'cleber@gmail.com', 
                                             password: '222222', 
                                             full_name: 'Cleber Feltrin',
                                             birth_date: '22/01/1983')
        cleber_enrollment = Enrollment.create!(job: job_rebase, candidate: candidate_cleber)
        proposal_to_cleber = Proposal.create!(message_from_company: 'Teria disponibilidade para início imediato',
                                              start_date: Date.current,
                                              salary_proposal: '3500,00',
                                              enrollment: cleber_enrollment)
        
        login_as candidate_cleber, scope: :candidate
        visit enrollments_path
        page.find("#enrollment-#{cleber_enrollment.id}").click_on 'Você tem uma proposta para esta vaga'
        click_on 'Recusar'

        expect(current_path).to eq(decline_proposal_path(proposal_to_cleber))
        expect(page).to have_content('Justificativa para declínio da proposta')
        expect(page).to have_field('proposal_reason')
    end

    scenario 'and does not allow to decline with fill in less than 20 characters' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        job_rebase = Job.create!(title: 'Dev. Júnior', 
                                 description: 'Desenvolvedor ruby on rails',
                                 income: '3000,00', level: 'Júnior', 
                                 limit_date: Date.current + 1.day,
                                 quantity: 5, company: rebase_company)
        candidate_cleber = Candidate.create!(email: 'cleber@gmail.com', 
                                             password: '222222', 
                                             full_name: 'Cleber Feltrin',
                                             birth_date: '22/01/1983')
        cleber_enrollment = Enrollment.create!(job: job_rebase, candidate: candidate_cleber)
        proposal_to_cleber = Proposal.create!(message_from_company: 'Teria disponibilidade para início imediato',
                                              start_date: Date.current,
                                              salary_proposal: '3500,00',
                                              enrollment: cleber_enrollment)
        
        login_as candidate_cleber, scope: :candidate
        visit decline_proposal_path(proposal_to_cleber)
        fill_in 'Justificativa', with: 'Não quero'
        click_on 'Declinar Proposta'

        cleber_enrollment.reload
        proposal_to_cleber.reload

        expect(page).to have_content('Justificativa é muito curto')
        expect(cleber_enrollment.status).to eq('pending')
        expect(proposal_to_cleber.status).to eq('pending')
    end

    scenario 'successfully' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        job_rebase = Job.create!(title: 'Dev. Júnior', 
                                 description: 'Desenvolvedor ruby on rails',
                                 income: '3000,00', level: 'Júnior', 
                                 limit_date: Date.current + 1.day,
                                 quantity: 5, company: rebase_company)
        candidate_cleber = Candidate.create!(email: 'cleber@gmail.com', 
                                             password: '222222', 
                                             full_name: 'Cleber Feltrin',
                                             birth_date: '22/01/1983')
        cleber_enrollment = Enrollment.create!(job: job_rebase, candidate: candidate_cleber)
        proposal_to_cleber = Proposal.create!(message_from_company: 'Teria disponibilidade para início imediato',
                                              start_date: Date.current,
                                              salary_proposal: '3500,00',
                                              enrollment: cleber_enrollment)
        
        login_as candidate_cleber, scope: :candidate
        visit decline_proposal_path(proposal_to_cleber)
        fill_in 'Justificativa', with: 'Não tenho disponibilidade para esta data'
        click_on 'Declinar Proposta'

        cleber_enrollment.reload
        proposal_to_cleber.reload
        
        expect(current_path).to eq(enrollments_path)
        expect(page.find('#flash-messages')).to have_content('Proposta declinada pelo candidato')
        expect(cleber_enrollment.status).to eq('candidate_refused')
        expect(proposal_to_cleber.status).to eq('candidate_declined')
    end
end