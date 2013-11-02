ENV['SSL_CERT_FILE'] = File.join(File.dirname(__FILE__), 'cacert.pem')

require File.expand_path('../boot', __FILE__)
require 'csv'
# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module ShoolooV2
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :local

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    #configure exception or error messages
    config.exceptions_app = self.routes
  end
    SIGN_UP = 10
    PROFILE_COMPLETE = 40
    REFERRAL_REQUEST = 20 
    REFERRAL_WITHDRAW = -20
    AUTHORIZATION_REQUEST = 30 
    AUTHORIZATION_WITHDRAW = -30 
    SIGN_IN = 8
    POST_NEW = 10
    POST_DELETE = -10
    COMMENT_NEW = 15    
    COMMENT_DELETE = -15
    COMMENT_BONUS = 15
    COMMENT_BONUS_DELETE = -15
    RATING_NEW = 8
    RATING_DELETE = -8
    REFERRAL_GRANT = 60
    AUTHORIZATION_GRANT = 4
    LIKE_POST = 1
    UNLIKE_POST = -1
    LIKE_COMMENT = 1
    UNLIKE_COMMENT = -1
    LIKE_LESSON = 1
    UNLIKE_LESSON = -1
    NUDGE = 2
    FOLLOW = 4
    UNFOLLOW = -4
    INVITE_COMMENT = 2
    ALARM_POST = -30
    UNALARM_POST = 30
    ALARM_COMMENT = -20
    UNALARM_COMMENT = 20
    INVITE_JOIN = 10
    GIFT_THRESHOLD = 60.0
end
