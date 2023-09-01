# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      post '/files/generate', to: 'files#generate'
    end
  end
end
