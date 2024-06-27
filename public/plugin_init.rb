require 'i18n'
require 'aspace_i18n'
require_relative '../lib/aspace_custom_locales_helper'

Rails.application.config.before_initialize do

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

      plugin_dir = File.expand_path("..", File.expand_path(File.dirname(__FILE__)))

      # load eveything we can
      config.i18n.load_path += Dir[File.join(plugin_dir, 'common', '**', '*.yml')]
      config.i18n.load_path += Dir[File.join(plugin_dir, 'public', '**', '*.yml')]

      if (AppConfig.has_key?(:aspace_custom_localizations_public_default) && 
        AppConfig.has_key?(:aspace_custom_localizations) && 
        AppConfig[:aspace_custom_localizations].include?(AppConfig[:aspace_custom_localizations_public_default].to_s))

        AspaceCustomLocalesHelper.set_locale('public', plugin_dir, config)

      end
      
    end

  end

end
