require 'rails_helper'

feature 'candidate can enroll to job' do
    scenario 'only if authenticated' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        Job.create!(title: 'Dev. Junior', 
                    description: 'Desenvolvedor ruby on rails',
                    income: '3000,00', level: 'Júnior', 
                    limit_date: Date.current + 1.day,
                    quantity: 5, company: rebase_company)
        
        visit root_path

        click_on 'Visualizar Vagas'
        click_on 'Aplicar para a vaga'

        expect(current_path).to eq(new_candidate_session_path)
    end

    scenario 'successfully' do
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

        visit new_candidate_session_path
        
        fill_in 'E-mail', with: 'cae@gmail.com'
        fill_in 'Senha', with: '123456'
        click_on 'Log in'
        click_on 'Aplicar para a vaga'
        
        rebase_job.reload

        expect(current_path).to eq(jobs_path)
        expect(page.find('#flash-messages')).to have_content('Cadastro para vaga realizada com sucesso')
        expect(candidate).to eq(rebase_job.candidates.first)
    end

    scenario 'and can view enrollments' do
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

        visit new_candidate_session_path
        
        fill_in 'E-mail', with: 'cae@gmail.com'
        fill_in 'Senha', with: '123456'
        click_on 'Log in'
        click_on 'Aplicar para a vaga'
        page.find('#navigation-menu').click_on 'Painel Candidato'

        enrollment = candidate.reload.enrollments.first

        expect(page.find("#enrollment-#{enrollment.id}")).to have_content("Empresa: #{rebase_company.name}")
        expect(page.find("#enrollment-#{enrollment.id}")).to have_content("Título: #{enrollment.job.title}")
        expect(page.find("#enrollment-#{enrollment.id}")).to have_content("Descrição: #{enrollment.job.description}")
        expect(page.find("#enrollment-#{enrollment.id}")).to have_content("Data Limite: #{I18n.l enrollment.job.limit_date}")
    end

    scenario 'and can not enroll twice in a same job' do
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
        Enrollment.create!(job: rebase_job, candidate: candidate)
        
        login_as candidate, scope: :candidate
        visit jobs_path
        click_on 'Aplicar para a vaga'

        expect(page.find('#flash-messages')).to have_content('Candidato já cadastrado para esta vaga')
        expect(rebase_job.enrollments.count).to eq(1)
    end
end