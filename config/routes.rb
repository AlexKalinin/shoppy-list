Rails.application.routes.draw do
  root 'marketing#root'

  devise_for :users


  namespace :adminka do

  end
end
