source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'bootstrap-sass', '2.1'
gem 'bcrypt-ruby', '3.0.1'
gem 'faker', '1.0.1'
gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'
gem 'jquery-rails', '3.1.0'
gem 'paperclip', :git => 'git://github.com/thoughtbot/paperclip.git'
gem 'formtastic'
gem 'formtastic-bootstrap'
gem 'pg'
gem 'taps'
gem 'ransack', :git => "git://github.com/ernie/ransack.git"
gem 'fancybox-rails'
gem 'whenever', :require => false
gem 'cancan'
gem "recaptcha", :require => "recaptcha/rails"
gem 'sitemap_generator'
gem 'meta-tags', :require => 'meta_tags'
gem 'thin'
gem 'best_in_place'
gem 'sendgrid'
gem 'twilio-ruby'
gem 'obscenity'
gem 'client_side_validations', :github => 'bcardarella/client_side_validations', :branch => '3-2-stable'
gem 'client_side_validations-formtastic'
gem 'friendly_id', :github => 'norman/friendly_id', :branch => '4.0-stable'
gem 'exception_notification'
gem 'roo'
gem 'ckeditor', '4.0.6'
gem 'validate_url'
gem 'truncate_html'
gem 'chosen-rails'
gem 'chartkick'
gem 'iconv'
gem 'state_machine'

group :development, :test do
  gem 'rspec-rails', '2.11.0'
  gem 'guard-rspec', '1.2.1'
  gem 'guard-spork', '1.2.0'  
  gem 'spork', '0.9.2'
  gem 'annotate', '2.5.0'
  gem 'pry-rails'
  gem 'pry-nav'
end

gem "letter_opener", :group => :development

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'factory_girl_rails', '4.1.0'
  gem 'cucumber-rails', '1.2.1', :require => false
  gem 'database_cleaner', '0.7.0'
  gem 'rb-fsevent', '0.9.1', :require => false
  gem 'growl', '1.0.3'
  gem 'launchy'
end

# Deploy with Capistrano
gem 'capistrano'

#Use unicorn as the app server
gem 'unicorn'

if RUBY_VERSION =~ /1.9/ 
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

