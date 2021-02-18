require 'rails_helper'

feature 'guest can navigate to jobs lists' do
    scenario 'from root_path' do
        visit root_path
        click_on 'Visualizar Vagas'

        expect(current_path).to eq(jobs_path)
        expect(page).to have_content('Vagas disponíveis para candidatos')
    end
    
    scenario 'and view available jobs if exists' do
        Domain.create!(name: 'rebase')
        Domain.create!(name: 'iugu')
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        iugu_company = Company.create!(name: 'Iugu Pagamentos', 
                                         address: 'Avenida Paulista, 7',
                                         domain: 'iugu') 
        job_pleno = Job.create!(title: 'Dev. Pleno', description: 'Desenvolvedor ruby on rails',
                                income: '5300,00', level: 'Pleno', limit_date: Date.current + 2.day,
                                quantity: 5, company: rebase_company)
        job_senior = Job.create!(title: 'Dev. Sênior', description: 'Desenvolvedor C#',
                                 income: '7000,00', level: 'Sênior', limit_date: Date.current + 3.day,
                                 quantity: 22, company: rebase_company)
        job_another_domain = Job.create!(title: 'Dev. Júnior', description: 'Desenvolvedor Javascript',
                                         income: '1500,00', level: 'Júnior', limit_date: Date.current + 1.day,
                                         quantity: 13, company: iugu_company)
        
        visit jobs_path
        
        expect(page.find("#job-#{job_pleno.id}")).to have_content("Empresa: #{job_pleno.company.name}")
        expect(page.find("#job-#{job_pleno.id}")).to have_content("Título: #{job_pleno.title}")
        expect(page.find("#job-#{job_pleno.id}")).to have_content("Descrição: #{job_pleno.description}")
        expect(page.find("#job-#{job_pleno.id}")).to have_content("Level: #{job_pleno.level}")
        expect(page.find("#job-#{job_pleno.id}")).to have_content("Quantidade: #{job_pleno.quantity}")
        expect(page.find("#job-#{job_pleno.id}")).to have_content("Data Limite: #{I18n.l job_pleno.limit_date}")

        expect(page.find("#job-#{job_senior.id}")).to have_content("Título: #{job_senior.title}")
        expect(page.find("#job-#{job_senior.id}")).to have_content("Descrição: #{job_senior.description}")
        expect(page.find("#job-#{job_senior.id}")).to have_content("Level: #{job_senior.level}")
        expect(page.find("#job-#{job_senior.id}")).to have_content("Quantidade: #{job_senior.quantity}")
        expect(page.find("#job-#{job_senior.id}")).to have_content("Data Limite: #{I18n.l job_senior.limit_date}")

        expect(page.find("#job-#{job_another_domain.id}")).to have_content("Empresa: #{job_another_domain.company.name}")
        expect(page.find("#job-#{job_another_domain.id}")).to have_content("Título: #{job_another_domain.title}")
        expect(page.find("#job-#{job_another_domain.id}")).to have_content("Descrição: #{job_another_domain.description}")
        expect(page.find("#job-#{job_another_domain.id}")).to have_content("Level: #{job_another_domain.level}")
        expect(page.find("#job-#{job_another_domain.id}")).to have_content("Quantidade: #{job_another_domain.quantity}")
        expect(page.find("#job-#{job_another_domain.id}")).to have_content("Data Limite: #{I18n.l job_another_domain.limit_date}")
    end

    scenario 'and does not view inactive job' do
        Domain.create!(name: 'rebase')
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        job_active = Job.create!(title: 'Dev. Pleno', description: 'Desenvolvedor ruby on rails',
                                 income: '5300,00', level: 'Pleno', limit_date: Date.current + 1.day,
                                 quantity: 5, company: rebase_company)
        job_inactive = Job.create!(title: 'Dev. Sênior', description: 'Desenvolvedor C#',
                                   income: '7000,00', level: 'Sênior', limit_date: Date.current + 2.day,
                                   quantity: 22, status: :inativo, company: rebase_company)
        
        visit jobs_path

        expect(page.find("#job-#{job_active.id}")).to have_content("Empresa: #{job_active.company.name}")
        expect(page.find("#job-#{job_active.id}")).to have_content("Título: #{job_active.title}")
        expect(page.find("#job-#{job_active.id}")).to have_content("Descrição: #{job_active.description}")
        expect(page.find("#job-#{job_active.id}")).to have_content("Level: #{job_active.level}")
        expect(page.find("#job-#{job_active.id}")).to have_content("Quantidade: #{job_active.quantity}")
        expect(page.find("#job-#{job_active.id}")).to have_content("Data Limite: #{I18n.l job_active.limit_date}")

        expect(page).not_to have_content("Título: #{job_inactive.title}")
        expect(page).not_to have_content("Descrição: #{job_inactive.description}")
        expect(page).not_to have_content("Level: #{job_inactive.level}")
        expect(page).not_to have_content("Quantidade: #{job_inactive.quantity}")
        expect(page).not_to have_content("Data Limite: #{I18n.l job_inactive.limit_date}")
    end

    scenario 'and does not view expired job' do
        Domain.create!(name: 'rebase')
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        job_active = Job.create!(title: 'Dev. Pleno', description: 'Desenvolvedor ruby on rails',
                                 income: '5300,00', level: 'Pleno', limit_date: Date.current + 1.day,
                                 quantity: 5, company: rebase_company)
        job_expired = Job.create!(title: 'Dev. Sênior', description: 'Desenvolvedor C#',
                                  income: '7000,00', level: 'Sênior', limit_date: '17/02/2021',
                                  quantity: 22, company: rebase_company)
        
        visit jobs_path

        expect(page.find("#job-#{job_active.id}")).to have_content("Empresa: #{job_active.company.name}")
        expect(page.find("#job-#{job_active.id}")).to have_content("Título: #{job_active.title}")
        expect(page.find("#job-#{job_active.id}")).to have_content("Descrição: #{job_active.description}")
        expect(page.find("#job-#{job_active.id}")).to have_content("Level: #{job_active.level}")
        expect(page.find("#job-#{job_active.id}")).to have_content("Quantidade: #{job_active.quantity}")
        expect(page.find("#job-#{job_active.id}")).to have_content("Data Limite: #{I18n.l job_active.limit_date}")

        expect(page).not_to have_content("Título: #{job_expired.title}")
        expect(page).not_to have_content("Descrição: #{job_expired.description}")
        expect(page).not_to have_content("Level: #{job_expired.level}")
        expect(page).not_to have_content("Quantidade: #{job_expired.quantity}")
        expect(page).not_to have_content("Data Limite: #{I18n.l job_expired.limit_date}")
    end

    scenario 'and show message for no jobs created' do
        Domain.create!(name: 'rebase')
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')

        visit jobs_path

        expect(page).to have_content('Sem vagas cadastradas no momento')
    end
end