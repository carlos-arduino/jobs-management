require 'rails_helper'

feature 'corporate user can edit a job' do
    scenario 'successfully' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456',
                                   company: rebase_company)
        job = Job.create!(title: 'Dev. Junior', 
                          description: 'Desenvolvedor ruby on rails',
                          income: '3000,00', level: 'Júnior', 
                          limit_date: '28/11/2021',
                          quantity: 5, company: rebase_company)

        login_as user_rebase, scope: :user
        visit company_page_path
        click_on 'Editar'
        
        fill_in 'Título', with: 'Dev. Pleno'
        fill_in 'Descrição', with: 'Desenvolvedor C#'
        fill_in 'Salário', with: '3500,00'
        page.select 'Pleno', from: 'Nível'
        fill_in 'Data limite', with: '29/03/2021'
        fill_in 'Quantidade', with: '10'

        click_on 'Atualizar Emprego'
        job.reload

        expect(page.find("#job-details-#{job.id}")).to have_content('Título: Dev. Pleno')
        expect(page.find("#job-details-#{job.id}")).to have_content('Descrição: Desenvolvedor C#') 
        expect(page.find("#job-details-#{job.id}")).to have_content('Level: Pleno') 
        expect(page.find("#job-details-#{job.id}")).to have_content('Quantidade: 10') 
        expect(page.find("#job-details-#{job.id}")).to have_content('Status: Ativo')
        expect(job).to eq(Job.last)
    end

    scenario 'and can return without edit' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456',
                                   company: rebase_company)
        job = Job.create!(title: 'Dev. Junior', 
                          description: 'Desenvolvedor ruby on rails',
                          income: '3000,00', level: 'Júnior', 
                          limit_date: '28/11/2021',
                          quantity: 5, company: rebase_company)

        login_as user_rebase, scope: :user
        visit company_page_path
        click_on 'Editar'
        
        fill_in 'Título', with: 'Dev. Pleno'
        fill_in 'Descrição', with: 'Desenvolvedor C#'
        fill_in 'Salário', with: '3500,00'
        page.select 'Pleno', from: 'Nível'
        fill_in 'Data limite', with: '29/03/2021'
        fill_in 'Quantidade', with: '10'

        click_on 'Cancelar'
        job.reload

        expect(page.find("#job-details-#{job.id}")).not_to have_content('Título: Dev. Pleno')
        expect(page.find("#job-details-#{job.id}")).not_to have_content('Descrição: Desenvolvedor C#') 
        expect(page.find("#job-details-#{job.id}")).not_to have_content('Quantidade: 10') 
        expect(page.find("#job-details-#{job.id}")).not_to have_content('Level: Pleno') 
        expect(job).to eq(Job.last)
    end

    scenario 'and can disable a specific active job' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456', 
                                   company: rebase_company)
        job_to_inactive = Job.create!(title: 'Dev. Junior', 
                                      description: 'Desenvolvedor ruby on rails',
                                      income: '3000,00', level: 'Júnior', 
                                      limit_date: '28/11/2021',
                                      quantity: 5, company: rebase_company)
        job_active = Job.create!(title: 'Dev. Pleno', 
                                 description: 'Desenvolvedor C#',
                                 income: '5000,00', level: 'Pleno', 
                                 limit_date: '15/03/2021',
                                 quantity: 22, company: rebase_company)

        login_as user_rebase, scope: :user
        visit company_page_path
        page.find("#job-#{job_to_inactive.id}").click_on 'Inativar'

        job_to_inactive.reload
        job_active.reload

        expect(page.find("#job-details-#{job_to_inactive.id}")).to have_content('Status: Inativo')
        expect(job_to_inactive.inactive?).to be_truthy
        expect(job_active.active?).to be_truthy
    end

end