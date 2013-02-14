ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/autorun'
require 'minitest/spec'

# require "minitest/rails"
# MiniTest::Rails.override_testunit!

# Add `gem "minitest/rails/capybara"` to the test group of your Gemfile
# and uncomment the following if you want Capybara feature tests
# require "minitest/rails/capybara"

# Uncomment if you want awesome colorful output
require "minitest/pride"

class MiniTest::Spec
  include FactoryGirl::Syntax::Methods
end

include Devise::TestHelpers

class DateTime
  include Comparable
end
