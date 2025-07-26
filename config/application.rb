require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ApkTicketSeminar
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.autoload_paths += %W(#{config.root}/config/routes)
    config.active_record.yaml_column_permitted_classes = [Symbol]
    config.time_zone = "Jakarta"
    config.assets.precompile += %w(certification.css)
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
