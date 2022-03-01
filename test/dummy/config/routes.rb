Rails.application.routes.draw do
  mount Forest::Feed::Engine => "/forest-feed"
end
