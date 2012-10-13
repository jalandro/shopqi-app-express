source 'https://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end



# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem "devise"
gem "shopqi-app"
gem "shopqi-app-webhook"
gem "settingslogic"
gem "jquery-rails"
gem "spine-rails"
gem "ruby-haml-js"
gem "whenever", :require => false
gem "exception_notification"
gem "unicorn"
group :development do
  gem "haml-rails"
  gem "rvm-capistrano", "~> 1.2.5"
  gem "letter_opener"
  gem "guard-livereload"
  gem "guard-spork"
  gem "guard-rspec"
  gem "guard-bundler"
  gem "guard-unicorn"
end

group :test do
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "capybara"
  gem "database_cleaner"
end