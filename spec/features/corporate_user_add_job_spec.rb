require 'rails_helper'

feature 'corporate user can add job' do
    scenario 'from root path' do
        corporate_user = User.create!(email: 'cae@rebase.com.br', password: '123456')
        domain = Domain.create!(name: 'rebase')
        company = Company.create!(name: 'Rebase', user: corporate_user)

        visit root_path
        click_on 'Corporativo'
        fill_in 'E-mail', with: 'cae@rebase.com.br'
        fill_in 'Senha', with: '123456'
        click_on 'Log in'
        click_on 'Adicionar Emprego'

        expect(current_path).to eq(new_job_path)
    end

    scenario 'and guest can not add job' do
        visit root_path
        click_on 'Corporativo'

        expect(current_path).to eq(new_user_session_path)
    end

    scenario 'successfully' do
        
    end



end