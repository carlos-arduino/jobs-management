class JobsController < ApplicationController
    before_action :authenticate_user!
    
    def new
        @company = Company.find(params[:company_id])
        @job = Job.new
    end
    
    def create
        @company = Company.find(params[:company_id])
        @job = Job.new(job_params)
        @job.company_id = @company.id

        if @job.save
            redirect_to companies_path
        else
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

    def disable
        @job = Job.find(params[:id])
        @job.inativo!
        redirect_to companies_path
    end

    private

    def job_params
        params.require(:job).permit(:title, :description, :income, :level, :limit_date, :quantity)
    end
    
end