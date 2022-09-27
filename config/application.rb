require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module CookieMonster
  class Application < Rails::Application
    config.load_defaults 7.0
    config.autoload_paths += %W( lib/ )
    config.middleware.use ActionDispatch::Cookies
  end
end
