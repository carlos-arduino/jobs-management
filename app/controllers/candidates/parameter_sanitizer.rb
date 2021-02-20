class Candidates::ParameterSanitizer < Devise::ParameterSanitizer
    def initialize(*)
      super
      permit(:sign_up, keys: [:email, :full_name, :social_name,
             :cpf, :cel_number, :biography, :birth_date])
      permit(:account_update, keys: [:email, :full_name, :social_name,
             :cpf, :cel_number, :biography, :birth_date])
    end
end