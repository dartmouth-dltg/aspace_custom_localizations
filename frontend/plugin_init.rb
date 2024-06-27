require_relative '../lib/aspace_custom_locales_helper'

Rails.application.config.before_initialize do

  module ArchivesSpace

    class Application < Rails::Application

      plugin_dir = File.expand_path("..", File.expand_path(File.dirname(__FILE__)))

      # load everything we can
      config.i18n.load_path += Dir[File.join(plugin_dir, 'common', '**', '*.yml')]
      config.i18n.load_path += Dir[File.join(plugin_dir, 'reports', '**', '*.yml')]
      config.i18n.load_path += Dir[File.join(plugin_dir, 'frontend', '**', '*.yml')]

      # check to see if we can set the required default
      if (AppConfig.has_key?(:aspace_custom_localizations_default) && 
        AppConfig.has_key?(:aspace_custom_localizations) && 
        AppConfig[:aspace_custom_localizations].include?(AppConfig[:aspace_custom_localizations_default].to_s))

          AspaceCustomLocalesHelper.set_locale('frontend', plugin_dir, config)
                
      end

    end
  end
end

Rails.application.config.after_initialize do

  module ApplicationHelper

    def supported_locales_options
      enhanced_supported_locales.map { |k, v| [t("enumerations.language_iso639_2.#{v}"), k] }
    end

    def enhanced_supported_locales
      enhanced_locales = I18n::LOCALES.dup
      plugin_dir = File.expand_path("..", File.expand_path(File.dirname(__FILE__)))

      AppConfig[:aspace_custom_localizations].each do |loc, lang|
        if AspaceCustomLocalesHelper.allow_frontend_locale?(loc, plugin_dir)
          enhanced_locales[loc] = lang
        end
      end

      enhanced_locales
    end

  end

end