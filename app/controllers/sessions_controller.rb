class SessionsController < ApplicationController

  #lvd001- Con esta instrucción saltamos el before_action :require_login del application_controller.rb, 
  # evitamos así caer en un bucle
  skip_before_action :require_login, only: [:new, :create]
  
  def new
  end

  def create
  
    usuario = Usuario.find_by(cCodUsuario: params[:session][:cCodUsuario].downcase)

    if usuario && usuario.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in usuario
      redirect_to '/welcome'

    else
      flash.now[:danger] = 'Combinación de Código de usuario/password incorrecta'
      render 'new'
    end
    
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
