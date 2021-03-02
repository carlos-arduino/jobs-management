require 'rails_helper'

feature 'corporate user management enrollments' do
    scenario 'can view enrollment link if exists in job' do
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

        Enrollment.create!(job: job_rebase, candidate: candidate_cleber)

        login_as user_rebase, scope: :user
        visit company_page_path
        
        expect(page).to have_content("Painel da empresa #{rebase_company.name}")
        expect(page.find("#job-#{job_rebase.id}")).to have_link('Visualizar Inscrições')
    end

    scenario 'and can not view enrollment link if does not exists' do
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

        login_as user_rebase, scope: :user
        visit company_page_path

        expect(page.find("#job-#{job_rebase.id}")).not_to have_link('Visualizar Inscrições')
    end

    scenario 'and can visit link for show details of a enrollment' do
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

        expect(current_path).to eq(enrollment_path(cleber_enrollment))
        expect(page).to have_content('Detalhes da Candidatura')
    end

    scenario 'and show justify view for decline candidate' do
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
        page.find("#view-enrollment-#{cleber_enrollment.id}").click_on 'Declinar Candidatura'

        expect(current_path).to eq(decline_enrollment_path(cleber_enrollment))
    end

    scenario 'and does not allow decline for empty reason' do
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
        visit decline_enrollment_path(cleber_enrollment)
        fill_in 'Justificativa', with: ''
        click_on 'Declinar Candidato'

        expect(page).to have_content('Justificativa é muito curto')
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
        visit decline_enrollment_path(cleber_enrollment)
        fill_in 'Justificativa', with: 'Candidato não preencheu requisitos'
        click_on 'Declinar Candidato'

        expect(page.find('#flash-messages')).to have_content('Candidato declinado com sucesso') 
        expect(current_path).to eq(job_path(job_rebase))
        expect(page.find("#enrollment-#{cleber_enrollment.id}")).to have_content('Declinado pela empresa')
    end
end