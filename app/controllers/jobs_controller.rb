class JobsController < ApplicationController
    before_action :authenticate_user!
    
    def new
        @company = Company.find(params[:company_id])
    end
    
    def create
        @company = Company.find(params[:company_id])
        begin
            @company.jobs.create!(job_params)
            redirect_to companies_path
        rescue ActiveRecord::RecordInvalid => invalid
            render :new
        end
    end

    def show
        @job = Job.find(params[:id])
    end

    def edit
        @company = Company.find(params[:company_id])
    end

    private

    def job_params
        params.require(:job).permit(:title, :description, :income, :level, :limit_date, :quantity)
    end
    
end