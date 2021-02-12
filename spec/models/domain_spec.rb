require 'rails_helper'

describe Domain do
  context 'validation' do
    it { should validate_presence_of(:name) }
    
    it { should validate_uniqueness_of(:name) }
  end

  context '#extract domain' do
    it 'can convert to downcase given a email' do
      downcase_email = 'mariadobairro@campuscode.com'
      upcase_email = 'JOSEDASCOUVES@IUGU.COM.BR'
      mixcase_email = 'eDuaRdO@ViNdI.com'
      number_domain = 'vinicius@banco15.com.br'

      extracted_downcase_domain = Domain.extract_domain(downcase_email)
      extracted_upacase_domain = Domain.extract_domain(upcase_email)
      extracted_mixcase_domain = Domain.extract_domain(mixcase_email)
      extracted_number_domain = Domain.extract_domain(number_domain)

      expect(extracted_downcase_domain).to eq('campuscode')
      expect(extracted_upacase_domain).to eq('iugu')
      expect(extracted_mixcase_domain).to eq('vindi')
      expect(extracted_number_domain).to eq('banco15')
    end
  end

end
