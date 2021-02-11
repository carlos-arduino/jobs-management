class Domain < ApplicationRecord
    validates :name , presence: true
    validates :name , uniqueness: true

    def self.extract_domain(email)
        email.gsub(/.+@([^.]+).+/, '\1').downcase
    end
end
