require 'i18n'
require_relative '../lib/aspace_custom_locales_helper'

# sets your locale to one of the newly added localizations if a new locale is set
if (AppConfig.has_key?(:aspace_custom_localizations_default) && 
    AppConfig.has_key?(:aspace_custom_localizations) && 
    AppConfig[:aspace_custom_localizations].include?(AppConfig[:aspace_custom_localizations_default].to_s))
  
  plugin_dir = File.expand_path("..", File.expand_path(File.dirname(__FILE__)))

  if AspaceCustomLocalesHelper.check_default_locale_existence(plugin_dir)
    AppConfig[:locale] = AppConfig[:aspace_custom_localizations_default]
    I18n.default_locale = AppConfig[:locale]
    puts "\n\nAspace Custom Locales Plugin: Default locale set to custom locale: #{I18n.default_locale}\n\n"
  else
    puts "\n\nAspace Custom Locales Plugin: WARNING - Localization files for the selected default language do not exist. Please ensure that you have 
    a localization file and an enumerations file named: #{AppConfig[:aspace_custom_localizations_default].to_s}.yml 
    in frontend/locales and frontend/locales/enums of this plugin.\n\n"
  end  

end
  