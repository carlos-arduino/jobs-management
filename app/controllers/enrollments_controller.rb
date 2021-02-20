class EnrollmentsController < ApplicationController
    before_action :authenticate_candidate!
    def index
        @enrollments = Enrollment.where(candidate: current_candidate)
    end
end