Rails.application.routes.draw do
  root 'marketing#root'

  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }


  namespace :adminka do
    root 'product_lists#index'
    resources :products do
      collection do
        get 'is_name_taken'
      end
    end
    resources(:product_lists, except: [:show, :new]) do
      member do
        delete 'product/:product_id' => 'product_lists#remove_product', as: :remove_product_from
        post 'product/:product_id' => 'product_lists#add_product', as: :add_product_to
        get 'products' => 'product_lists#products', as: :products_of
        post 'toggle_done' => 'product_lists#toggle_done', as: :toggle_done
      end

      collection do
        get 'is_name_taken'
      end
    end
  end
end
