Rails.application.routes.draw do
  root 'marketing#root'

  devise_for :users


  namespace :adminka do
    root 'product_lists#index'
    resources :products
    resources(:product_lists, except: [:show, :new]) do
      member do
        delete 'product/:product_id' => 'product_lists#remove_product', as: :remove_product_from
        get 'product' => 'product_lists#new_product', as: :new_product_to
        post 'product' => 'product_lists#create_product', as: :add_product_to
        get 'products' => 'product_lists#products', as: :products_of
        post 'toggle_done' => 'product_lists#toggle_done', as: :toggle_done
      end

      collection do
        get 'is_name_taken' => 'product_lists#name_taken?', as: :is_name_taken
      end
    end
  end
end
