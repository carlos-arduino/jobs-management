require 'rails_helper'

describe User do
 
  context '#extract domain' do
    it 'can separate domain given a email' do
      employee = User.create!(email: 'eduardo@vindi.com.br', password: '123456')

      domain = employee.extract_domain
      
      expect(domain).to eq('vindi')
    end

    it 'can convert to downcase given a email with capital letters, mix letters and with number' do
      employee_maria = User.create!(email: 'mariadobairro@campuscode.com', password: '123456')
      employee_jose = User.create!(email: 'JOSE@IUGU.COM.BR', password: '123456')
      employee_eduardo = User.create!(email: 'eDuaRdO@ViNdI.com', password: '123456')
      employee_vinicius = User.create!(email: 'vinicius@banco15.com.br', password: '123456')
 

      extracted_downcase_domain = employee_maria.extract_domain
      extracted_upacase_domain = employee_jose.extract_domain
      extracted_mixcase_domain = employee_eduardo.extract_domain
      extracted_number_domain = employee_vinicius.extract_domain

      expect(extracted_downcase_domain).to eq('campuscode')
      expect(extracted_upacase_domain).to eq('iugu')
      expect(extracted_mixcase_domain).to eq('vindi')
      expect(extracted_number_domain).to eq('banco15')
    end
  end
end
