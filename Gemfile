source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'therubyracer'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'font-awesome-rails'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
gem 'capistrano', '~> 3.0', require: false, group: :development
group :development do
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-passenger', require: false

  # Sunspot 2.2.1 switches to SOLR 5
  gem 'sunspot_solr', '2.2.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails'
  gem 'annotate'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'que-testing'
end

gem 'pg'

# authentication
gem 'sorcery'
gem 'cancancan'

gem 'airbrake', '~> 4.0'

gem 'mail_room'
gem 'que'

gem 'reverse_markdown'
gem 'htmlentities'

gem 'carrierwave', '>= 1.0.0.beta', '< 2.0'
gem 'mini_magick'

gem 'acts_as_tenant'

# markdown
gem 'redcarpet'

gem 'simple_calendar'

# Sunspot 2.2.1 switches to SOLR 5
gem 'sunspot_rails', '2.2.0'