require_relative '../lib/aspace_custom_locales_helper'

Rails.application.config.after_initialize do

  module ApplicationHelper

    def supported_locales_options
      enhanced_supported_locales.map { |k, v| [t("enumerations.language_iso639_2.#{v}"), k] }
    end

    def enhanced_supported_locales
      enhanced_locales = I18n::LOCALES.dup
      plugin_dir = File.expand_path("..", File.expand_path(File.dirname(__FILE__)))

      if (AppConfig.has_key?(:aspace_custom_localizations) && 
          AppConfig[:aspace_custom_localizations].include?(AppConfig[:aspace_custom_localizations_default].to_s) && 
          AspaceCustomLocalesHelper.check_default_locale_existence(plugin_dir))

        AppConfig[:aspace_custom_localizations].each do |loc, lang|
          enhanced_locales[loc] = lang
        end

      end

      enhanced_locales
    end

  end

end