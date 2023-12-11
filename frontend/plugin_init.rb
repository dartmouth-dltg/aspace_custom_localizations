require_relative '../lib/aspace_custom_locales_helper'

Rails.application.config.before_initialize do
  if (AppConfig.has_key?(:aspace_custom_localizations_default) && 
    AppConfig.has_key?(:aspace_custom_localizations) && 
    AppConfig[:aspace_custom_localizations].include?(AppConfig[:aspace_custom_localizations_default].to_s))

    module ArchivesSpace

      class Application < Rails::Application

        localization = AppConfig[:aspace_custom_localizations_default]
        plugin_dir = File.expand_path("..", File.expand_path(File.dirname(__FILE__)))

        if (AspaceCustomLocalesHelper.default_locale_exist?(plugin_dir) &&
          AspaceCustomLocalesHelper.custom_common_locales_exist?(localization, plugin_dir))

          AppConfig[:locale] = localization
          config.i18n.load_path += Dir[File.join(plugin_dir, 'common', '**', '*.yml')]
          config.i18n.load_path += Dir[File.join(plugin_dir, 'reports', '**', '*.yml')]
          config.i18n.default_locale = AppConfig[:locale]
          region = I18n.t('enumerations.country_iso_3166.' + localization.to_s.upcase)
          language = I18n.t('enumerations.language_iso639_2.' + AppConfig[:aspace_custom_localizations][localization.to_s])

          puts "\n\nAspace Custom Locales Plugin:
          Default frontend locale set to custom locale: #{AppConfig[:locale]} 
          for country/region: #{region}
          with language: #{language}.\n\n"
        else  
          puts "\n\nAspace Custom Locales Plugin:
          WARNING - Frontend localization files for the selected default language do not exist. Please ensure that you have
          localization files named: #{AppConfig[:aspace_custom_localizations_default].to_s}.yml 
          in frontend/locales, common/locales, and common/locales/enums of this plugin.\n\n"
        end
                
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

      if (AppConfig.has_key?(:aspace_custom_localizations) && 
        AppConfig.has_key?(:aspace_custom_localizations_default) &&
        AppConfig[:aspace_custom_localizations].include?(AppConfig[:aspace_custom_localizations_default].to_s) && 
        AspaceCustomLocalesHelper.default_locale_exist?(plugin_dir) &&
        AspaceCustomLocalesHelper.custom_common_locales_exist?(AppConfig[:aspace_custom_localizations_default], plugin_dir))

        AppConfig[:aspace_custom_localizations].each do |loc, lang|
          if AspaceCustomLocalesHelper.allow_frontend_locale?(loc, plugin_dir)
            enhanced_locales[loc] = lang
          end
        end

      end

      enhanced_locales
    end

  end

end