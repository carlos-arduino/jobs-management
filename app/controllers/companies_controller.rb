class CompaniesController < ApplicationController
    before_action :authenticate_user!
    def index
        @company = Company.find_by(domain: current_user.extract_domain)
    end
    
    def edit
        @company = Company.find(params[:id])
    end

    def update
        @company = Company.find(params[:id])
        
        if @company.update(company_params)
            redirect_to company_page_path
        else
            render :edit
        end
    end

    private

    def company_params
        params.require(:company).permit(:name, :address, :cnpj, :site, :social_midia, :logo)
    end
end