class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  respond_to :html

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_global_info

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url
  end

  def new_session_path(scope)
    new_user_session_path
  end

  protected

  def configure_permitted_parameters
    [ :first_name, :last_name, :username, :sex, :is_univ_student, :is_student_at_minho_univ,
      :is_inf_eng_student_at_minho_univ, :is_cesium_associate, :cesium_associate_number, :minho_univ_student_id,
      :university, :course, :location, :profession
    ].each do |p|
      devise_parameter_sanitizer.permit(:sign_up, keys: [p])
    end

    [ :birthday, :biography, :facebook_account, :twitter_account,
      :github_account, :linked_in_account, :avatar, :cesium_associate_number
    ].each do |p|
      devise_parameter_sanitizer.permit(:account_update, keys: [p])
    end
  end

  def set_global_info
    @edition = Edition.find(2018)
    @activities = @edition.activities
  end
end
