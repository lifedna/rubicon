# config/initializers/devise.rb
Devise.setup do |config|
  config.case_insensitive_keys = [:email, :username]
end