require 'rails_helper'

feature 'candidate management account' do
    scenario 'can navigate to register page' do
        visit root_path
        click_on 'CANDIDATO'
        click_on 'Sign up'

        expect(current_path).to eq(new_candidate_registration_path)
    end
    
    scenario 'can register yourself' do
        visit new_candidate_registration_path

        fill_in 'E-mail', with: 'cae@gmail.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'
        fill_in 'Nome completo',  with: 'Carlos Eduardo Arduino'
        fill_in 'Data de nascimento', with: '25/11/1983'
        click_on 'Sign up'

        expect(page.find("#flash-messages")).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
        expect(page.find("#navigation-menu")).to have_link('Log out')
        expect(current_path).to eq(root_path)
    end

    scenario 'and can not register with different passwords' do
        visit new_candidate_registration_path

        fill_in 'E-mail', with: 'cae@gmail.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '1234567'
        fill_in 'Nome completo',  with: 'Carlos Eduardo Arduino'
        fill_in 'Data de nascimento', with: '25/11/1983'
        click_on 'Sign up'

        expect(page.find("#error_explanation")).to have_content('Não foi possível salvar candidato: 1 erro')
    end

    scenario 'do not show link for log-out with no login candidate' do
        candidate = Candidate.create!(email: 'cae@rebase.com', password: '123456',
                                      full_name: 'Carlos Arduino',
                                      birth_date: '25/11/983')
        
        login_as candidate, scope: :candidate
        visit root_path
        click_on 'Log out'

        expect(page.find("#navigation-menu")).not_to have_link('Log out')
    end

    scenario 'and can not register with existed e-mail' do
        candidate = Candidate.create!(email: 'cae@gmail.com', password: '123456',
                                      full_name: 'Carlos Arduino',
                                      birth_date: '25/11/983')
        
        visit new_candidate_registration_path

        fill_in 'E-mail', with: 'cae@gmail.com'
        fill_in 'Senha', with: '111111'
        fill_in 'Confirme sua senha', with: '111111'
        fill_in 'Nome completo',  with: 'Caê Alves'
        fill_in 'Data de nascimento', with: '25/11/1999'

        click_on 'Sign up'

        expect(page.find("#error_explanation")).to have_content('Não foi possível salvar candidato: 1 erro')
    end

    scenario 'and can not register with empty required fields' do
        visit new_candidate_registration_path

        fill_in 'E-mail', with: 'cae@gmail.com'
        fill_in 'Senha', with: ''
        fill_in 'Confirme sua senha', with: '111111'
        fill_in 'Nome completo',  with: 'Caê Alves'
        fill_in 'Data de nascimento', with: '25/11/1999'

        click_on 'Sign up'

        expect(page.find("#error_explanation")).to have_content('Não foi possível salvar candidato: 2 erros')
    end

    scenario 'and can log in' do
        candidate = Candidate.create!(email: 'cae@gmail.com', password: '123456',
                                      full_name: 'Carlos Arduino',
                                      birth_date: '25/11/1983')
        
        visit root_path

        click_on 'CANDIDATO'
        fill_in 'E-mail', with: 'cae@gmail.com'
        fill_in 'Senha', with: '123456'

        click_on 'Log in'

        expect(current_path).to eq(jobs_path)
        expect(page.find("#navigation-menu")).to have_content('cae@gmail.com')
    end
end
