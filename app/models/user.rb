class User < ApplicationRecord
  before_save :set_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def set_role
    self.supervisor_role = true unless public_domain?
  end

  def public_domain?
    domain = Domain.extract_domain(self.email)
    PublicDomain.exists?(name: domain)
  end

  def corporate_domain_exists?
    domain = Domain.extract_domain(self.email)
    Domain.exists?(name: domain)
  end

end
