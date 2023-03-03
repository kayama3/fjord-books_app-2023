Rails.application.routes.draw do
  resources :books
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  scope "(:locale)", locale: /en|ja/ do
    resources :books
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
