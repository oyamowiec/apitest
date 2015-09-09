Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :locations
      resources :organizations

      post "model_type_prices/:id", to: "group_organizations#model_type_prices"
    end
  end

end
