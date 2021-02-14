class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def extract_domain
    email.gsub(/.+@([^.]+).+/, '\1').downcase
  end
end

# TODO - Extrair para módulo de helper o método extract_domain utlizado pelas classes User e RegistrationsController.
