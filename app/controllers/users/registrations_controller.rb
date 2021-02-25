# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  
  def create
    if company_domain_exists?(extract_domain_from_params)
      super do
        resource.company_id = @company.id
        resource.save
      end
    else
      @company = Company.create!(domain: extract_domain_from_params,
                                 name: 'Modifique esse campo com nome da empresa')
      super do
        resource.company_id = @company.id
        if not resource.save
          @company.destroy
        end
      end
    end
  end
  
  private

  def after_sign_up_path_for(resource)
    if company_generated_with_new_user?(resource, @company)
      edit_company_path(@company)
    else
      company_page_path
    end
  end
  
  def company_domain_exists?(domain)
    @company = Company.find_by(domain: domain)
  end

  def company_generated_with_new_user?(user, company)
    interval_seconds = (user.created_at - company.created_at) * 1.0
    interval_seconds < 5.0
  end

  def extract_domain_from_params
    params[:user][:email].gsub(/.+@([^.]+).+/, '\1').downcase
  end

end
