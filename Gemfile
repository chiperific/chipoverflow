# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.4'

gem 'bootsnap', require: false
# generate fake Author names on the fly
gem 'faker', '~> 2.23.0'
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'haml-rails', '~> 2.0'
gem 'importmap-rails'
gem 'pg', '~> 1.4.4'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4'
# Use Sass to process CSS
gem 'sassc-rails'
gem 'sprockets-rails'
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'haml_lint'
  gem 'html2haml'
  gem 'letter_opener_web'
  gem 'rubocop'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda'
  gem 'webdrivers'
end
