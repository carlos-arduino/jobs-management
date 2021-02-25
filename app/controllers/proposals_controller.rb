class ProposalsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    before_action :authenticate_candidate!, only: [:accept, :decline, :declined]
    
    
    def new
        @enrollment = Enrollment.find(params[:enrollment_id])
        @proposal = Proposal.new
    end

    def create
        @enrollment = Enrollment.find(params[:enrollment_id])
        @proposal = Proposal.new(proposal_params)
        @proposal.enrollment_id = @enrollment.id
        
        if  @proposal.save
            redirect_to job_path(@enrollment.job), notice: 'Proposta criada com sucesso'
        else
            render :new
        end
    end

    def show
        @proposal = Proposal.find(params[:id])
    end

    def accept
        @proposal = Proposal.find(params[:id])
        Proposal.transaction do
            begin
                @proposal.accepted!
                @proposal.enrollment.accepted!
                redirect_to enrollments_path, notice: 'Proposta aceita'
            rescue ActiveRecord::RecordInvalid
                render :show
            end
        end
    end

    def decline
        @proposal = Proposal.includes(:enrollment).find(params[:id])
    end

    def declined
        @proposal = Proposal.find(params[:id])
        Proposal.transaction do
            begin
                @proposal.status = 'candidate_declined'
                @proposal.update!(declined_params)
                @proposal.enrollment.candidate_refused!
                redirect_to enrollments_path, alert: 'Proposta declinada pelo candidato'
            rescue ActiveRecord::RecordInvalid
                render :decline
            end
        end
    end

    private

    def proposal_params
        params.require(:proposal).permit(:message_from_company, :salary_proposal, :start_date)
    end

    def declined_params
        params.require(:proposal).permit(:reason)
    end
    
end