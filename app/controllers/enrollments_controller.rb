class EnrollmentsController < ApplicationController
    before_action :authenticate_candidate!, only: [:index]
    before_action :authenticate_user!, only: [:show, :decline, :declined]

    def index
        @enrollments = Enrollment.includes(:job).where(candidate: current_candidate)
    end

    def show
        @enrollment = Enrollment.includes(:job, :candidate).find(params[:id])
    end

    def decline
        @enrollment = Enrollment.find(params[:id])
    end

    def declined
        @enrollment = Enrollment.find(params[:id])
        @enrollment.status = 'declined'
        if @enrollment.update(enrollment_params)
            redirect_to job_path(@enrollment.job), notice: 'Candidato declinado com sucesso!'
        else
            render :decline
        end
    end

    private

    def enrollment_params
        params.require(:enrollment).permit(:reason)
    end
end