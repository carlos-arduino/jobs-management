class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def corporate_domain_exists?
    domain = Domain.extract_domain(self.email)
    Domain.exists?(name: domain)
  end

end
