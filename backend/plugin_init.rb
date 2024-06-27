require 'i18n'
require 'aspace_i18n'
require_relative '../lib/aspace_custom_locales_helper'

ArchivesSpaceService.loaded_hook do

  plugin_dir = File.expand_path("..", File.expand_path(File.dirname(__FILE__)))

  # load everything we can
  I18n.load_path += Dir[File.join(plugin_dir, 'common', '**', '*.yml')]
  I18n.load_path += Dir[File.join(plugin_dir, 'reports', '**', '*.yml')]
  I18n.load_path += Dir[File.join(plugin_dir, 'frontend', '**', '*.yml')]
  
  if AppConfig.has_key?(:aspace_custom_localizations)
    AppConfig[:aspace_custom_localizations].each do |localization|
      if AspaceCustomLocalesHelper.allow_frontend_locale?(localization, plugin_dir)
        I18n.available_locales << localization
      end
    end
  end

  if (AppConfig.has_key?(:aspace_custom_localizations_default) && 
    AppConfig.has_key?(:aspace_custom_localizations) && 
    AppConfig[:aspace_custom_localizations].include?(AppConfig[:aspace_custom_localizations_default].to_s))

      AspaceCustomLocalesHelper.set_locale('backend', plugin_dir, nil)
            
  end

end
    