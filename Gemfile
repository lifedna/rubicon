source :gemcutter
source 'http://rubygems.org'

# Bundle edge Rails instead:
gem 'rails',   '~> 3.2.6'

# database
# gem 'pg'
gem 'mongoid', '~> 3.0.0'

group :assets do
  # Asset template engines
  gem 'sass-rails',              '~> 3.1'
  gem 'bootstrap-sass',          '~> 2.2.1.1'
  gem "font-awesome-sass-rails", '~> 2.0.0'
  gem 'uglifier',                '~>1.0.3'
  gem 'coffee-rails'
  gem 'compass-rails'
  gem 'rack'

  # javascript
  gem 'jquery-rails'
  gem 'jquery-ui-rails'
  gem 'jquery-ui-themes'
  gem 'execjs'
  gem 'tinymce-rails'
  gem 'haml'
  gem 'haml-rails'
end

# user authentication
gem 'devise'
# gem 'omniauth',         '~> 1.0.2'
# gem 'omniauth-ecourts', '~> 1.0.2'

# needed for 3.1rc on Linux. Not needed after 3.1 final
# gem 'therubyracer', :group => :development

# general
gem 'acts-as-taggable-on'
gem 'redcarpet'
gem 'will_paginate', '~>3.0.0'
gem 'sanitize'
gem 'nokogiri'
gem 'simple_form'
gem 'pygments.rb'
gem "github-markup",   "~> 0.7.4",  require: 'github/markup'

group :development, :test do
  gem 'sqlite3'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'thin',                     :platform => :ruby
  gem 'factory_girl_rails'
  gem 'rake'
  gem 'pry',       :require => false
end

group :development do
  gem 'rails3-generators'
  gem 'awesome_print', :require => 'ap'
  gem 'hirb'
  gem 'pry'
end

group :test do
  # Pretty printed test output
  gem 'turn', '~>0.8.3', :require => false
  gem 'forgery'
  gem 'simplecov'
  gem 'metrical'
  gem 'forgery'
  gem 'rspec'
  gem 'minitest'
  gem 'minitest-rails'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-minitest'
  gem 'guard-livereload'
end

group :linux_test do
  gem 'test_notifier'
  gem 'rb-inotify'
  gem 'libnotify'
end

# Use unicorn as the web server
gem 'unicorn', :group => :production
