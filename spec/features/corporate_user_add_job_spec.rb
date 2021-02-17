require 'rails_helper'

feature 'corporate user can add a job' do
    scenario 'from root path successfully' do
        Domain.create!(name: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456')
        Company.create!(name: 'Rebase Tecnologia', 
                        address: 'Rua Alameda Santos, 45',
                        domain: 'rebase')

        visit root_path
        click_on 'Corporativo'        
        fill_in 'E-mail', with: 'cae@rebase.com'
        fill_in 'Senha', with: '123456'
        click_on 'Log in'
        click_on 'Cadastrar oferta de vagas'

        fill_in 'Title', with: 'Dev. Junior'
        fill_in 'Description', with: 'Desenvolvedor ruby'
        fill_in 'Income', with: '3000,00'
        page.select 'Júnior', from: 'Level'
        fill_in 'Limit date', with: '28/02/2021'
        fill_in 'Quantity', with: '5'

        click_on 'Criar Job'

        expect(current_path).to eq(companies_path)
        expect(page).to have_content('Título: Dev. Junior')
        expect(page).to have_content('Descrição: Desenvolvedor ruby')
        expect(page).to have_content('Quantidade: 5')
    end

    scenario 'and can cancel process' do
        Domain.create!(name: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456')
        Company.create!(name: 'Rebase Tecnologia', 
                        address: 'Rua Alameda Santos, 45',
                        domain: 'rebase')

        login_as user_rebase, scope: :user
        visit companies_path
        click_on 'Cadastrar oferta de vagas'

        fill_in 'Title', with: 'Dev. Junior'
        fill_in 'Description', with: 'Desenvolvedor ruby'
        fill_in 'Income', with: '3000,00'
        page.select 'Júnior', from: 'Level'
        fill_in 'Limit date', with: '28/02/2021'
        fill_in 'Quantity', with: '5'

        click_on 'Cancelar'
        
        expect(page).not_to have_content('Título: Dev. Junior')
        expect(page).not_to have_content('Descrição: Desenvolvedor ruby')
        expect(page).not_to have_content('Quantidade: 5')
        expect(Job.last).to eq(nil)
    end

    scenario 'and can not add job with empty required fieds' do
        Domain.create!(name: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456')
        Company.create!(name: 'Rebase Tecnologia', 
                        address: 'Rua Alameda Santos, 45',
                        domain: 'rebase')

        login_as user_rebase, scope: :user
        visit companies_path
        click_on 'Cadastrar oferta de vagas'

        fill_in 'Title', with: ''
        fill_in 'Description', with: ''
        fill_in 'Income', with: '3000,00'
        page.select 'Júnior', from: 'Level'
        fill_in 'Limit date', with: ''
        fill_in 'Quantity', with: ''
        
        click_on 'Criar Job'

        expect(page).to have_content('não pode ficar em branco', count: 4)
    end

end