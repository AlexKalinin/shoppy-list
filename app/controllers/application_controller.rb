class ApplicationController < ActionController::Base
  include LocaleConcern

  protect_from_forgery with: :exception
end
