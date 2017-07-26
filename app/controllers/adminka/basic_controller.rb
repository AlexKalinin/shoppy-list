module Adminka
  class BasicController < ActionController::Base
    include ::LocaleConcern

    protect_from_forgery with: :exception

    before_action :authenticate_user!  unless Rails.env.development?

    layout 'adminka'
  end
end