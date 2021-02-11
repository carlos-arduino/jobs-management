require 'rails_helper'

feature 'user management' do
    scenario 'user can register' do
        visit root_path
        click_on 'Sign up'

        expect(current_path).to eq(new_user_registration_path)
    end
end