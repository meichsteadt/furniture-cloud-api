Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'authenticate', to: 'authentication#authenticate'
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
    resources :images, :deliveries, :reviews
  end
  resources :categories, :categories_products, :financings
end
