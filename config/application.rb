require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KeibaExpectationApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # ロケール用の.ymlをロード
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]

    # デフォルトの言語を日本語に設定
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators do |g|
      g.test_framework :rspec,
      view_specs: false,
      helper_specs: false,
      routing_specs: false
    end

    # use sidekiq for job executor
    config.active_job.queue_adapter = :sidekiq
  end
end
