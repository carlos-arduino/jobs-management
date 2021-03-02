require 'rails_helper'

feature 'Corporate user create proposal for enrollment candidate' do
    scenario 'from company page domain' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456',
                                   company: rebase_company)
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
        
        login_as user_rebase, scope: :user
        visit company_page_path
        page.find("#job-#{job_rebase.id}").click_on 'Visualizar Inscrições'
        page.find("#enrollment-#{cleber_enrollment.id}").click_on 'Pendente'

        expect(page.find("#view-enrollment-#{cleber_enrollment.id}")).to have_link('Criar Proposta')
    end

    scenario 'and show form with proposal requirements' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456',
                                   company: rebase_company)
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
        
        login_as user_rebase, scope: :user
        visit enrollment_path(cleber_enrollment)
        click_on 'Criar Proposta'

        expect(current_path).to eq(new_enrollment_proposal_path(cleber_enrollment))
        expect(page).to have_field('proposal_message_from_company')
        expect(page).to have_field('proposal_salary_proposal')
        expect(page).to have_field('proposal_start_date')
    end

    scenario 'and does not alow create with empty fields' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456',
                                   company: rebase_company)
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
        
        login_as user_rebase, scope: :user
        visit new_enrollment_proposal_path(cleber_enrollment)
        fill_in 'Mensagem da empresa', with: ''
        fill_in 'Proposta salarial', with: ''
        fill_in 'Data de início', with: ''
        click_on 'Criar Proposta'

        expect(page).to have_content('Mensagem da empresa é muito curto')
        expect(page).to have_content('não pode ficar em branco', count: 2)
    end

    scenario 'successfully' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456',
                                   company: rebase_company)
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
        
        login_as user_rebase, scope: :user
        visit new_enrollment_proposal_path(cleber_enrollment)
        fill_in 'Mensagem da empresa', with: 'Teria disponibilidade para início imediato?'
        fill_in 'Proposta salarial', with: '3500,00'
        fill_in 'Data de início', with: Date.current
        click_on 'Criar Proposta'

        cleber_proposal = cleber_enrollment.reload.proposal
        
        expect(page.find('#flash-messages')).to have_content('Proposta criada com sucesso')
        expect(cleber_enrollment.status).to eq('pending')
        expect(cleber_proposal.status).to eq('pending')
    end
end