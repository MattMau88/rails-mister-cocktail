Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'cocktails#index'

  resources :cocktails, only: [:new, :create, :index, :show] do
    resources :doses, shallow: true, except: [:index, :edit, :update, :show]
  end
end

# INSTRUCTIONS: Our app will not allow users to create ingredients
# we(admin) will generate a static seed of ingredients to choose from
# => ingredients route, controller, and view(s) not needed
