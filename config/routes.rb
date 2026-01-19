Rails.application.routes.draw do
  root "home#index"

  get "signin" => "sessions#new"
  post "signin" => "sessions#create"
  delete "signout" => "sessions#destroy"

  get "register" => "registrations#new"
  post "register" => "registrations#create"

  get "dashboard" => "assessments#index"
  get "assessments/new" => "assessments#new", as: :new_assessment
  post "assessments" => "assessments#create"
  patch "assessments/:id" => "assessments#update", as: :assessment

  get "invite/:token" => "invites#show", as: :invite
  patch "invite/:token" => "invites#update"

  get "invite/:token/company" => "company#edit", as: :company
  patch "invite/:token/company" => "company#update"

  get "invite/:token/qualify" => "qualification#edit", as: :qualify
  patch "invite/:token/qualify" => "qualification#update"

  get "invite/:token/modules" => "modules#edit", as: :modules
  patch "invite/:token/modules" => "modules#update"

  get "invite/:token/assessment/:pillar_id/:metric_id" => "metrics#show", as: :assessment_step
  patch "invite/:token/assessment/:pillar_id/:metric_id" => "metrics#update", as: :assessment_update

  get "invite/:token/results" => "results#show", as: :results

  get "up" => "rails/health#show", as: :rails_health_check
end
