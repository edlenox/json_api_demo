class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session



  rescue_from Exception do |e|
    error(e)
  end

  def routing_error
    raise "routing error"
  end

  protected

  def error(e)
    error_info = {
      :error => "internal-server-error",
      :exception => "#{e.class.name} : #{e.message}",
    }
    error_info[:trace] = e.backtrace[0,10] # if Rails.env.development?
    render :json => error_info.to_json, :status => 500
  end

end
