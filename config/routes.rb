Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'authenticate', to: 'authentication#authenticate'
  post 'authenticate_site', to: 'authentication#authenticate_site'
  resources :products do
    resources :related_products
    resources :product_items do
      resources :prices
    end
  end
  resources :promotions do
    get '/products', to: 'promotions_products#index'
  end
  resources :stores do
    resources :images, :deliveries, :reviews, :locations
  end
  resources :mattresses do
    resources :sizes
  end
  resources :categories_products, :financings ,:parent_categories, :searches, :categories

  resources :parent_categories do
    resources :categories do
      resources :set_types, :set_types_products
    end
  end
end
