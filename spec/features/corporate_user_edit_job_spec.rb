require 'rails_helper'

feature 'corporate user can edit a job' do
    scenario 'successfully' do
        Domain.create!(name: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456')
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        job = Job.create!(title: 'Dev. Junior', description: 'Desenvolvedor ruby on rails',
                          income: '3000,00', level: 'Júnior', limit_date: '28/11/2021',
                          quantity: 5, company: rebase_company)

        login_as user_rebase, scope: :user
        visit companies_path
        click_on 'Editar'
        
        fill_in 'Title', with: 'Dev. Pleno'
        fill_in 'Description', with: 'Desenvolvedor C#'
        fill_in 'Income', with: '3500,00'
        page.select 'Pleno', from: 'Level'
        fill_in 'Limit date', with: '29/03/2021'
        fill_in 'Quantity', with: '10'

        click_on 'Atualizar Job'
        job.reload

        expect(page.find("#job-#{job.id}")).to have_content('Título: Dev. Pleno')
        expect(page.find("#job-#{job.id}")).to have_content('Descrição: Desenvolvedor C#') 
        expect(page.find("#job-#{job.id}")).to have_content('Level: Pleno') 
        expect(page.find("#job-#{job.id}")).to have_content('Quantidade: 10') 
        expect(page.find("#job-#{job.id}")).to have_content('Status da vaga: ativo')
        expect(job).to eq(Job.last)
    end

    scenario 'and can return without edit' do
        Domain.create!(name: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456')
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        job = Job.create!(title: 'Dev. Junior', description: 'Desenvolvedor ruby on rails',
                          income: '3000,00', level: 'Júnior', limit_date: '28/11/2021',
                          quantity: 5, company: rebase_company)

        login_as user_rebase, scope: :user
        visit companies_path
        click_on 'Editar'
        
        fill_in 'Title', with: 'Dev. Pleno'
        fill_in 'Description', with: 'Desenvolvedor C#'
        fill_in 'Income', with: '3500,00'
        page.select 'Pleno', from: 'Level'
        fill_in 'Limit date', with: '29/03/2021'
        fill_in 'Quantity', with: '10'

        click_on 'Cancelar'
        job.reload

        expect(page.find("#job-#{job.id}")).not_to have_content('Título: Dev. Pleno')
        expect(page.find("#job-#{job.id}")).not_to have_content('Descrição: Desenvolvedor C#') 
        expect(page.find("#job-#{job.id}")).not_to have_content('Quantidade: 10') 
        expect(page.find("#job-#{job.id}")).not_to have_content('Level: Pleno') 
        expect(job).to eq(Job.last)
    end

    scenario 'and can disable a specific active job' do
        Domain.create!(name: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456')
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        job_to_inactive = Job.create!(title: 'Dev. Junior', description: 'Desenvolvedor ruby on rails',
                                      income: '3000,00', level: 'Júnior', limit_date: '28/11/2021',
                                      quantity: 5, company: rebase_company)
        job_active = Job.create!(title: 'Dev. Pleno', description: 'Desenvolvedor C#',
                                 income: '5000,00', level: 'Pleno', limit_date: '15/03/2021',
                                 quantity: 22, company: rebase_company)

        login_as user_rebase, scope: :user
        visit companies_path
        page.find("#job-#{job_to_inactive.id}").click_on 'Inativar'

        job_to_inactive.reload
        job_active.reload

        expect(page.find("#job-#{job_to_inactive.id}")).to have_content('Status da vaga: inativo')
        expect(page.find("#job-#{job_to_inactive.id}")).not_to have_link('Inativar')
        expect(job_to_inactive.inativo?).to be_truthy
        expect(page.find("#job-#{job_active.id}")).to have_link('Inativar')
        expect(job_active.ativo?).to be_truthy
    end

end