require 'rails_helper'

feature 'Candidate can accept proposal' do
    scenario 'and can view link if proposal exists' do
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
        Proposal.create!(message_from_company: 'Teria disponibilidade para início imediato',
                         start_date: Date.current,
                         salary_proposal: '3500,00',
                         enrollment: cleber_enrollment)
        
        login_as candidate_cleber, scope: :candidate
        visit root_path
        click_on 'Painel Candidato'

        expect(current_path).to eq(enrollments_path)
        expect(page).to have_content('Lista de vagas matriculadas')
        expect(page.find("#enrollment-#{cleber_enrollment.id}")).to have_link('Você tem uma proposta para esta vaga')
    end

    scenario 'and can not view link if proposal does not exists' do
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
        
        login_as candidate_cleber, scope: :candidate
        visit root_path
        click_on 'Painel Candidato'

        expect(page).to have_content('Lista de vagas matriculadas')
        expect(page).not_to have_link('Você tem uma proposta para esta vaga')
    end

    scenario 'and view proposal' do
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
        
        expect(current_path).to eq(proposal_path(proposal_to_cleber))
        expect(page).to have_content(proposal_to_cleber.message_from_company)
        expect(page).to have_content(I18n.l proposal_to_cleber.start_date)
        expect(page).to have_content(proposal_to_cleber.salary_proposal)
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
        visit proposal_path(proposal_to_cleber)
        click_on 'Aceitar'

        cleber_enrollment.reload
        proposal_to_cleber.reload

        expect(current_path).to eq(enrollments_path)
        expect(page.find('#flash-messages')).to have_content('Proposta aceita')
        expect(cleber_enrollment.status).to eq('accepted')
        expect(proposal_to_cleber.status).to eq('accepted')
    end
end