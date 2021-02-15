require 'rails_helper'

feature 'corporate user view list of jobs only for your company' do
    scenario 'from root path' do
        user_rebase = User.create!(email: 'cae@rebase.com.br', password: '123456')
        domain_rebase = Domain.create!(name: 'rebase')
        rebase_company = Company.create!(name: 'Rebase', domain: 'rebase',
                                         address: 'Rua Alameda Santos, 45')

        domain_iugu = Domain.create!(name: 'iugu')
        iugu_company = Company.create!(name: 'Iugu', domain: 'iugu', 
                                       address: 'Avenida Paulista, 412')

        job_rebase = Job.create!(title: 'Dev. Senior', description: 'Programador ruby',
                                 level: 0, limit_date: '15/03/2021', 
                                 quantity: 5, company: rebase_company)
        job_iugu = Job.create!(title: 'Dev. Junior', description: 'Programador C#',
                               level: 5, limit_date: '21/04/2021', 
                               quantity: 15, company: iugu_company)
                                 
        visit root_path
        click_on 'Corporativo'
        fill_in 'E-mail', with: 'cae@rebase.com.br'
        fill_in 'Senha', with: '123456'
        click_on 'Log in'
        
        
        expect(current_path).to eq(companies_path)
        
    end
end