require 'rails_helper'

describe User do
 
  context 'validation' do
    it { should validate_presence_of(:email) }
    
    it { should validate_presence_of(:password) }

  end
  context '#extract domain' do
    it 'can separate domain given a email' do
      vindi = Company.create!(name: 'Vindi', domain: 'vindi')
      employee = User.create!(email: 'eduardo@vindi.com.br', password: '123456',
                              company: vindi)

      domain = employee.extract_domain
      
      expect(domain).to eq('vindi')
    end

    it 'can convert to downcase given a email with capital letters, mix letters and with number' do
      vindi = Company.create!(name: 'Vindi', domain: 'vindi')
      iugu = Company.create!(name: 'Iugu', domain: 'iugu')
      campus_code = Company.create!(name: 'Campus Code', domain: 'campuscode')
      banco15 = Company.create!(name: 'Banco 15', domain: 'banco15')

      employee_maria = User.create!(email: 'mariadobairro@campuscode.com', password: '123456',
                                    company: campus_code)
      employee_jose = User.create!(email: 'JOSE@IUGU.COM.BR', password: '123456',
                                   company: iugu)
      employee_eduardo = User.create!(email: 'eDuaRdO@ViNdI.com', password: '123456',
                                      company: vindi)
      employee_vinicius = User.create!(email: 'vinicius@banco15.com.br', password: '123456',
                                       company: banco15)

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
