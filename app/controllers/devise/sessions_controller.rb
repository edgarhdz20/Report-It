class Devise::SessionsController < DeviseController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
  prepend_before_filter :allow_params_authentication!, :only => [ :new, :create ]
  skip_before_filter :verify_authenticity_token
  prepend_before_filter { request.env["devise.skip_timeout"] = true }
  layout "empty"
  
  respond_to :json  

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    if signed_in?
      self.resource = warden.authenticate!(auth_options)
      sign_in(resource_name, resource)        
      
      if request.content_type == "application/json"
        render json: {:login => "OK"}
      else
        set_flash_message(:notice, :signed_in) if is_navigational_format?
        respond_with resource, location: after_sign_in_path_for(resource)
      end
    elsif request.content_type == "application/json"
      render json: { :login => t("devise.failure.invalid") }
    else
      redirect_to new_user_session_path, alert: t("devise.failure.invalid")
    end
  end

  # DELETE /resource/sign_out
  def destroy
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_navigational_format?

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to redirect_path }
    end
  end

  protected

  def sign_in_params
#    devise_parameter_sanitizer.for(:sign_in)
#     params.permit(:username, :password)
  end

  def serialize_options(resource)
    methods = resource_class.authentication_keys.dup
    methods = methods.keys if methods.is_a?(Hash)
    methods << :password if resource.respond_to?(:password)
    { :methods => methods, :only => [:password] }
  end

  def auth_options
    { :scope => resource_name, :recall => "#{controller_path}#new" }
  end
end