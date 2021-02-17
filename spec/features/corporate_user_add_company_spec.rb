require 'rails_helper'

feature 'corporate user can add a company' do
    scenario 'and show form if email domain no exists' do
        visit root_path
        click_on 'Corporativo'
        click_on 'Sign up'
        
        fill_in 'E-mail', with: 'cae@rebase.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'

        click_on 'Sign up'

        expect(current_path).to eq(new_company_path)
    end

    scenario 'successfully' do
        visit root_path
        click_on 'Corporativo'
        click_on 'Sign up'
        
        fill_in 'E-mail', with: 'cae@rebase.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'

        click_on 'Sign up'

        fill_in 'Name', with: 'Campus Code Ltda.'
        fill_in 'Address', with: 'Alameda Santos, 41'
        fill_in 'Cnpj', with: '12345678/12'
        fill_in 'Site', with: 'www.campuscode.com.br'
        fill_in 'Social midia', with: 'campus.facebook.com.bla'
        
        click_on 'Criar Company'

        expect(current_path).to eq(company_path(Company.last))
    end

    scenario 'and do not show add company if a email domain exists' do
        Domain.create!(name: 'rebase')
        Company.create!(name: 'Rebase', address: 'Alameda Santos, 45', domain: 'rebase')

        visit root_path
        click_on 'Corporativo'
        click_on 'Sign up'
        
        fill_in 'E-mail', with: 'cae@rebase.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'

        click_on 'Sign up'

        expect(current_path).to eq(companies_path)
    end

    scenario 'and delete domain and first user if add company its canceled' do
        visit root_path
        click_on 'Corporativo'
        click_on 'Sign up'
        
        fill_in 'E-mail', with: 'cae@rebase.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'

        click_on 'Sign up'

        fill_in 'Name', with: 'Campus Code Ltda.'
        fill_in 'Address', with: 'Alameda Santos, 41'
        fill_in 'Cnpj', with: '12345678/12'
        fill_in 'Site', with: 'www.campuscode.com.br'
        fill_in 'Social midia', with: 'campus.facebook.com.bla'

        click_on 'Cancelar'

        expect(Domain.last).to eq(nil)
        expect(User.last).to eq(nil)
        expect(current_path).to eq(root_path)
    end

    scenario 'and can not add with empty required fields' do
        visit root_path
        click_on 'Corporativo'
        click_on 'Sign up'
        
        fill_in 'E-mail', with: 'cae@rebase.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'

        click_on 'Sign up'

        fill_in 'Name', with: ''
        fill_in 'Address', with: ''
        fill_in 'Cnpj', with: '12345678/12'
        fill_in 'Site', with: 'www.campuscode.com.br'
        fill_in 'Social midia', with: 'campus.facebook.com.bla'
        
        click_on 'Criar Company'

        expect(page).to have_content('não pode ficar em branco', count: 2)
    end
end
