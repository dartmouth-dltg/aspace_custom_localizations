require 'i18n'
require 'aspace_i18n'
require_relative '../lib/aspace_custom_locales_helper'

Rails.application.config.before_initialize do

  if (AppConfig.has_key?(:aspace_custom_localizations_public_default) && 
    AppConfig.has_key?(:aspace_custom_localizations) && 
    AppConfig[:aspace_custom_localizations].include?(AppConfig[:aspace_custom_localizations_public_default].to_s))

    module I18n

      def self.supported_locales
        enhanced_locales = LOCALES.dup
        plugin_dir = File.expand_path("..", File.expand_path(File.dirname(__FILE__)))
        AppConfig[:aspace_custom_localizations].each do |loc, lang|
          if AspaceCustomLocalesHelper.allow_public_locale?(loc, plugin_dir)
            enhanced_locales[loc] = lang
          end
        end

        enhanced_locales
      end

    end

    module ArchivesSpacePublic

      class Application < Rails::Application
        if (AppConfig.has_key?(:aspace_custom_localizations_public_default) && 
          AppConfig.has_key?(:aspace_custom_localizations) && 
          AppConfig[:aspace_custom_localizations].include?(AppConfig[:aspace_custom_localizations_public_default].to_s))
          
          plugin_dir = File.expand_path("..", File.expand_path(File.dirname(__FILE__)))

          if AspaceCustomLocalesHelper.check_default_public_locale_existence(plugin_dir)
            AppConfig[:locale] = AppConfig[:aspace_custom_localizations_public_default]
            config.i18n.default_locale = AppConfig[:locale]
            config.i18n.load_path += Dir[File.join(plugin_dir, 'common', '**', '*.yml')]
            puts "\n\nAspace Custom Locales Plugin: Default public locale set to custom locale: #{AppConfig[:locale]}\n\n"
          else
            puts "\n\nAspace Custom Locales Plugin: WARNING - Public localization files for the selected default language do not exist. Please ensure that you have 
            a localization file and an enumerations file named: #{AppConfig[:aspace_custom_localizations_public_default].to_s}.yml 
            in public/locales and public/locales/enums of this plugin.\n\n"
          end

        end
        
      end

    end
  end

end