Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
    get     "",         to: "media#index"
  end
end