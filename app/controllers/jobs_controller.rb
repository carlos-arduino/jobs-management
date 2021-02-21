class JobsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :search, :enroll]
    before_action :authenticate_candidate!, only: [:enroll]
    
    def index
        @jobs = Job.available_status_and_not_expired
        @fill_select_company = Company.pluck(:name)
    end

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
        @job = Job.includes(:enrollments, :candidates).find(params[:id])
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

    def search
        jobs_founded = Company.find_by(name: params[:c])
                              .jobs.available_status_and_not_expired
        @filter_jobs = jobs_founded.where('title like ? OR description like ?',
                                          "%#{params[:q]}%", "%#{params[:q]}%")
    end

    def enroll
        @job = Job.find(params[:id])
        if @job.enroll!(current_candidate)
            redirect_to jobs_path, notice: 'Cadastro para vaga realizada com sucesso'
        else
            redirect_to root_path, alert: 'Candidato já cadastrado para esta vaga'
        end
    end

    private

    def job_params
        params.require(:job)
              .permit(:title, :description, :income, :level, :limit_date, :quantity)
    end
    
end