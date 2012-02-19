class ApplicationController < ActionController::Base

  protect_from_forgery
  include GaterHelper
  
  #before_filter :require_signed_in
  
  def index
  
  end
  
end
