class CompaniesController < ApplicationController
    before_action :authenticate_user!
    def index
        @company = Company.find_by(domain: current_user.extract_domain)
    end
    
    def new
        @company = Company.new
    end

    def create
        @company = Company.new(company_params)
        @company.domain = current_user.extract_domain

        if @company.save
            redirect_to @company
        else
            render 'companies/new'
        end
    end

    def show
        @company = Company.find_by(domain: current_user.extract_domain)
    end

    private

    def company_params
        params.require(:company).permit(:name, :address, :cnpj, :site, :social_midia)
    end
end