require 'rails_helper'

describe Domain do
  context 'validation' do
    it { should validate_presence_of(:name) }
    
    it { should validate_uniqueness_of(:name) }
  end

  context '#extract domain' do
    it 'can convert to downcase given a email' do
      downcase_email = 'mariadobairro@gmail.com'
      upcase_email = 'JOSEDASCOUVES@HOTMAIL.COM.BR'
      mixcase_email = 'eDuaRdO@IcLoUd.com'

      extracted_downcase_domain = Domain.extract_domain(downcase_email)
      extracted_upacase_domain = Domain.extract_domain(upcase_email)
      extracted_mixcase_domain = Domain.extract_domain(mixcase_email)

      expect(extracted_downcase_domain).to eq('gmail')
      expect(extracted_upacase_domain).to eq('hotmail')
      expect(extracted_mixcase_domain).to eq('icloud')  
    end
  end

end
