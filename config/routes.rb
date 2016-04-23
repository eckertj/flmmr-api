Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
    get     "/media",         to: "media#index"
  end
end