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

        company_generated = Company.last

        expect(current_path).to eq(edit_company_path(company_generated))
    end

    scenario 'successfully' do
        visit root_path
        click_on 'Corporativo'
        click_on 'Sign up'
        
        fill_in 'E-mail', with: 'cae@rebase.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'

        click_on 'Sign up'

        fill_in 'Nome', with: 'Campus Code Ltda.'
        fill_in 'Endereço', with: 'Alameda Santos, 41'
        fill_in 'Cnpj', with: '12345678/12'
        fill_in 'Site', with: 'www.campuscode.com.br'
        fill_in 'Social midia', with: 'campus.facebook.com.bla'
        
        click_on 'Atualizar Empresa'

        expect(current_path).to eq(company_page_path)
    end

    scenario 'and do not shlow add company if a email domain exists' do
        Company.create!(name: 'Rebase', address: 'Alameda Santos, 45',
                        domain: 'rebase')
        sleep 3

        visit root_path
        click_on 'Corporativo'
        click_on 'Sign up'
        
        fill_in 'E-mail', with: 'cae@rebase.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'

        click_on 'Sign up'

        expect(current_path).to eq(company_page_path)
    end

    scenario 'and can not add with empty required fields' do
        visit root_path
        click_on 'Corporativo'
        click_on 'Sign up'
        
        fill_in 'E-mail', with: 'cae@rebase.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'

        click_on 'Sign up'

        fill_in 'Nome', with: ''
        fill_in 'Endereço', with: 'Av. Paulista'
        fill_in 'Cnpj', with: '12345678/12'
        fill_in 'Site', with: 'www.campuscode.com.br'
        fill_in 'Social midia', with: 'campus.facebook.com.bla'
        
        click_on 'Atualizar Empresa'

        expect(page).to have_content('não pode ficar em branco', count: 1)
    end
end
