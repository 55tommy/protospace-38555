class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  #deviseのコントローラーは編集できないから、継承しているApplicationControllerに追加したカラムの保存について書く
  
  private
  def configure_permitted_parameters 
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])
  end

end
