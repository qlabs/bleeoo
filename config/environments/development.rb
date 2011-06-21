Bleeoo::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  
  #OAuth keys
  OAUTH_TOKEN = '252609751-v0tp87zVikVmuGmgnpdWCMSXOFZ5JmnJwuhkkLS0'
  OAUTH_TOKEN_SECRET = 'weqNI4TDt2NmDw7FOVduFPUWlXZ2iYTb0STblT1ypo'
  TWITTER_CONSUMER_KEY = '4n4WpH0dCVdMmEy8VUnJnw'
  TWITTER_CONSUMER_SECRET = 'LlbMxxRSOVI4c0EOPSno24CNnVudGgMXF3CZ9DMS5s'  
  
end

