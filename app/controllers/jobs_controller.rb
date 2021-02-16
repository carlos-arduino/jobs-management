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
            render 'jobs/new'
        end
    end

    def show
        @job = Job.find(params[:id])
    end

    def edit
        @company = Company.find(params[:company_id])
        @job = Job.find(params[:id])
    end

    def update
        @company = Company.find(params[:company_id])
        @job = Job.find(params[:id])
        
        if @job.update(job_params)
            redirect_to companies_path
        else
            render 'jobs/edit'
        end
    end

    private

    def job_params
        params.require(:job).permit(:title, :description, :income, :level, :limit_date, :quantity)
    end
    
end