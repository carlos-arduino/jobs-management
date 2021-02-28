require 'rails_helper'

feature 'corporate user management account' do
    scenario 'can navigate to register page' do
        visit root_path
        click_on 'Corporativo'
        click_on 'Sign up'

        expect(current_path).to eq(new_user_registration_path)
    end
    
    scenario 'can register yourself' do
        visit new_user_registration_path

        fill_in 'E-mail', with: 'cae@rebase.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'
        click_on 'Sign up'

        expect(page.find("#flash-messages")).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
        expect(page.find("#navigation-menu")).to have_link('Log out')
    end

    scenario 'and can not register with different passwords' do
        visit new_user_registration_path

        fill_in 'E-mail', with: 'cae@rebase.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '1234567'
        click_on 'Sign up'

        expect(page.find("#error_explanation")).to have_content('Não foi possível salvar usuário corporativo: 1 erro')
    end

    scenario 'do not show link for log-out with no login user' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456',
                                   company: rebase_company)
        
        login_as user_rebase, scope: :user
        visit root_path
        click_on 'Log out'

        expect(page.find("#navigation-menu")).not_to have_link('Log out')
    end

    scenario 'and can not register with existed e-mail' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        user_rebase = User.create!(email: 'cae@rebase.com', password: '123456',
                                   company: rebase_company)
        
        visit new_user_registration_path

        fill_in 'E-mail', with: 'cae@rebase.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'
        click_on 'Sign up'

        expect(page.find("#error_explanation")).to have_content('Não foi possível salvar usuário corporativo: 1 erro')
    end
end
