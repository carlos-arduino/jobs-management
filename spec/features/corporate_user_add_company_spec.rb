require 'rails_helper'

feature 'corporate user can add a company' do
    scenario 'show form if email domain no exists' do
        visit root_path
        click_on 'Corporativo'
        click_on 'Sign up'
        
        fill_in 'E-mail', with: 'cae@rebase.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'

        click_on 'Sign up'

        expect(current_path).to eq(new_company_path)      
    end

    scenario 'can add a new company' do
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

    scenario 'do not show add company if a email domain exists' do
        Domain.create!(name: 'rebase')

        visit root_path
        click_on 'Corporativo'
        click_on 'Sign up'
        
        fill_in 'E-mail', with: 'cae@rebase.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'

        click_on 'Sign up'

        expect(current_path).to eq(root_path)
    end
end











