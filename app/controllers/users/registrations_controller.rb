# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :create_domain!, only: [:create], unless: :domain_exists?
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  
  @new_company_redirect_seletor = false

  # DELETE /resource
  def destroy
    domain = Domain.find_by(name: current_user.extract_domain)
    domain.destroy
    user = User.find(current_user.id)
    user.destroy

    redirect_to root_path
  end
  
  private

  def after_sign_up_path_for(resource)
    if @new_company_redirect_seletor
      new_company_path
    else
      companies_path
    end
  end

  def domain_exists?
    Domain.exists?(name: extract_domain_from_params)  
  end

  def create_domain!
    Domain.create!(name: extract_domain_from_params)
    @new_company_redirect_seletor = true
  end

  def extract_domain_from_params
    params[:user][:email].gsub(/.+@([^.]+).+/, '\1').downcase
  end

end
