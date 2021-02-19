class ApplicationController < ActionController::Base
   
  protected
   def devise_parameter_sanitizer
    if resource_class == Candidate
      Candidates::ParameterSanitizer.new(Candidate, :candidate, params)
    else
      super # Use the default one
    end
  end
end
