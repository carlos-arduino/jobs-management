class EnrollmentsController < ApplicationController
    before_action :authenticate_candidate!, only: [:index]
    before_action :authenticate_user!, only: [:show, :edit, :update]

    def index
        @enrollments = Enrollment.includes(:job).where(candidate: current_candidate)
    end

    def show
        @company = Company.find(params[:company_id])
        @enrollment = Enrollment.includes(:job, :candidate).find(params[:id])
    end

    def edit
        @company = Company.find(params[:company_id])
        @job = Job.find(params[:job_id])
        @enrollment = Enrollment.find(params[:id])
    end

    def update
        @company = Company.find(params[:company_id])
        @job = Job.find(params[:job_id])
        @enrollment = Enrollment.find(params[:id])
        @enrollment.status = 'declinado'
        if @enrollment.update(enrollment_params)
            redirect_to company_job_path(@company, @job), notice: 'Candidato declinado com sucesso!'
        else
            render 'enrollments/edit'
        end
    end

    private

    def enrollment_params
        params.require(:enrollment).permit(:reason)
    end
end