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

  #The path used after sign up.
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

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end



  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end


  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
