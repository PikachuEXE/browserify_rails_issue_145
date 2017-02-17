require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsSprocketsIssue420
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.assets.precompile +=[
      "application/require_common_js_modules.js",
      "application.js",
    ]

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # call browserify for packing/bundleing js
    # use babelify to transpile extensions .es6 to es2015 (stage-2 1.async await 2.object_rest_spread 3. class)
    config.browserify_rails.commandline_options = [
      #optimize the asset:precompile speed
      #https://github.com/substack/node-browserify#usage
      #http://stackoverflow.com/a/17005540/838346
      "--insert-globals=false",
      "--detect-globals=false",
      "-t [ babelify --presets [ es2015 stage-2 ] --plugins [ transform-flow-strip-types ] --extensions .es6 ] --extension=.es6",
    ]

    config.assets.configure do |env|
    env.cache = ActiveSupport::Cache.lookup_store(
    :null_store,
    )
    end

    config.log_level = "DEBUG"

    existing_log_level_name = config.log_level
      Rails.logger = begin
      STDOUT.sync = true

      logger = Logger.new(STDOUT)
      logger = ActiveSupport::TaggedLogging.new(logger) if defined?(ActiveSupport::TaggedLogging)
      logger.level = Logger.const_get(existing_log_level_name)
      logger
    end
    end
end
