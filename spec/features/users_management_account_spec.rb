require 'rails_helper'

feature 'user management account' do
    scenario 'user guest can navigate to registration page' do
        visit root_path
        click_on 'Sign up'

        expect(current_path).to eq(new_user_registration_path)
    end

    scenario 'and can register yourself' do
        visit new_user_registration_path

        fill_in 'E-mail', with: 'cae@email.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'
        click_on 'Sign-up'

        expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
    end

    scenario 'and can register with different passwords' do
        visit new_user_registration_path

        fill_in 'E-mail', with: 'cae@email.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '1234567'
        click_on 'Sign-up'

        expect(page).to have_content('Não foi possível salvar usuário: 1 erro')
    end
end

# TODO - finalizar demais processos gerenciamento de usuários login, logout