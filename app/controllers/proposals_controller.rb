class ProposalsController < ApplicationController
    before_action :authenticate_user!, only: [:index, :new, :create]
    before_action :authenticate_candidate!, only: [:update]
    
    def index;end
    
    def new
        @company = Company.find(params[:company_id])
        @job = Job.find(params[:job_id])
        @enrollment = Enrollment.find(params[:enrollment_id])
        @proposal = Proposal.new
    end

    def create
        @company = Company.find(params[:company_id])
        @job = Job.find(params[:job_id])
        @enrollment = Enrollment.find(params[:enrollment_id])
        @proposal = Proposal.new(proposal_params)
        @proposal.enrollment_id = @enrollment.id
        
        if  @proposal.save
            redirect_to company_job_path(@company, @job), notice: 'Proposta criada com sucesso'
        else
            render :new
        end
    end

    def show
        @company = Company.find(params[:company_id])
        @enrollment = Enrollment.find(params[:enrollment_id])
        @proposal = Proposal.find(params[:id])
    end

    def update
        @proposal = Proposal.find(params[:id])
        @enrollment = Enrollment.find(params[:enrollment_id])

        Proposal.transaction do
            begin
                @proposal.aceito!
                @enrollment.update_attribute(:status, 'aceito')    
            rescue ActiveRecord::RecordInvalid
                render :show 
            end
        end
        redirect_to enrollments_path, notice: 'Proposta aceita'
    end

    def decline
        @job = Job.find(params[:job_id])
        @enrollment = Enrollment.find(params[:enrollment_id])
        @proposal = Proposal.find(params[:id])
    end

    def candidate_declined
        @proposal = Proposal.find(params[:id])
        @proposal.status = 'declinado'
        @enrollment = @proposal.enrollment

        Proposal.transaction do
            begin
                @proposal.update(declined_params)
                @enrollment.update_attribute(:status, 'candidato_recusou')    
            rescue ActiveRecord::RecordInvalid
                render :decline
            end
        end
        redirect_to enrollments_path, alert: 'Proposta declinada pelo candidato'
    end

    private

    def proposal_params
        params.require(:proposal).permit(:message_from_company, :salary_proposal, :start_date)
    end

    def declined_params
        params.require(:proposal).permit(:reason)
    end
    
end