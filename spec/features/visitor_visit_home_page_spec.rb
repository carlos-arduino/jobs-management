require 'rails_helper'

feature 'Visitor visit home page and' do
    scenario 'successfully' do
        visit root_path

        expect(page).to have_content('Bem vindo')
        expect(page).to have_link('Visualizar Vagas')
        expect(page).to have_link('Corporativo')
        expect(page).not_to have_link('Login')
        expect(page).not_to have_link('Sign up')
    end
end

# TODO = WIP inserir processo para cadastro de guest que irão aplicar para as vagas