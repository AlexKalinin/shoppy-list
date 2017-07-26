module Adminka
  class BasicController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    layout 'adminka'
  end
end