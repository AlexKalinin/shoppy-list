Rails.application.routes.draw do
  root 'marketing#root'

  devise_for :users


  namespace :adminka do
    root 'product_lists#index'
    resources :products
    resources :product_lists do
      member do
        delete 'product/:product_id' => 'product_lists#remove_product', as: :remove_product_from
        get 'product' => 'product_lists#new_product', as: :new_product_to
        post 'product' => 'product_lists#create_product', as: :add_product_to
        get 'products' => 'product_lists#products', as: :products_of
      end

      collection do
        get 'is_busy' => 'product_lists#is_busy', as: :is_busy
      end
    end
  end
end
