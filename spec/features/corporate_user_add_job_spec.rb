require 'rails_helper'

feature 'corporate user can add a job' do
    scenario 'from root path successfully' do
        company_rebase = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456',
                                   company: company_rebase)

        visit root_path
        click_on 'Corporativo'        
        fill_in 'E-mail', with: 'cae@rebase.com'
        fill_in 'Senha', with: '123456'
        click_on 'Log in'
        click_on 'Cadastrar oferta de vagas'

        fill_in 'Título', with: 'Dev. Junior'
        fill_in 'Descrição', with: 'Desenvolvedor ruby'
        fill_in 'Salário', with: '3000,00'
        page.select 'Júnior', from: 'Nível'
        fill_in 'Data limite', with: '28/02/2022'
        fill_in 'Quantidade', with: '5'

        click_on 'Criar Emprego'

        job_created = Job.last

        expect(current_path).to eq(job_path(job_created))
        expect(page).to have_content('Título: Dev. Junior')
        expect(page).to have_content('Descrição: Desenvolvedor ruby')
        expect(page).to have_content('Quantidade: 5')
    end

    scenario 'and can cancel process' do
        company_rebase = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456',
                                   company: company_rebase)

        login_as user_rebase, scope: :user
        visit company_page_path
        click_on 'Cadastrar oferta de vagas'

        fill_in 'Título', with: 'Dev. Junior'
        fill_in 'Descrição', with: 'Desenvolvedor ruby'
        fill_in 'Salário', with: '3000,00'
        page.select 'Júnior', from: 'Nível'
        fill_in 'Data limite', with: '28/02/2021'
        fill_in 'Quantidade', with: '5'

        click_on 'Cancelar'
        
        expect(page).not_to have_content('Título: Dev. Junior')
        expect(page).not_to have_content('Descrição: Desenvolvedor ruby')
        expect(page).not_to have_content('Quantidade: 5')
        expect(Job.last).to eq(nil)
    end

    scenario 'and can not add job with empty required fieds' do
        company_rebase = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456',
                                   company: company_rebase)

        login_as user_rebase, scope: :user
        visit company_page_path
        click_on 'Cadastrar oferta de vagas'

        fill_in 'Título', with: ''
        fill_in 'Descrição', with: ''
        fill_in 'Salário', with: '3000,00'
        page.select 'Júnior', from: 'Nível'
        fill_in 'Data limite', with: ''
        fill_in 'Quantidade', with: ''
        
        click_on 'Criar Emprego'

        expect(page).to have_content('não pode ficar em branco', count: 4)
    end

end