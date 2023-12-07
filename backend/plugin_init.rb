module I18n
  def self.supported_locales
    enhanced_locales = LOCALES
  
    if AppConfig.has_key?(:aspace_custom_localizations)
      AppConfig[:aspace_custom_localizations].each do |loc, lang|
        enhanced_locales[loc] = lang
      end
    end
  
    enhanced_locales
  end
end

# sets your locale to one of the newly added localizations if a new locale is set
if AppConfig.has_key?(:aspace_custom_localizations_default) && AppConfig.has_key?(:aspace_custom_localizations) && AppConfig[:aspace_custom_localizations].include?(AppConfig[:aspace_custom_localizations_default].to_s)
  
  # check if the new locales files actually exist and only set if they do
  plugin_directory = File.expand_path("..", File.expand_path(File.dirname(__FILE__)))

  locales = File.join(plugin_directory,"frontend","locales","#{AppConfig[:aspace_custom_localizations_default].to_s}.yml")
  enums = File.join(plugin_directory,"frontend","locales","enums","#{AppConfig[:aspace_custom_localizations_default].to_s}.yml")

  if File.exist?(locales) && File.exist?(enums)
    AppConfig[:locale] = AppConfig[:aspace_custom_localizations_default]
  else
    puts "WARNING: Localization files for the selected default language do not exist. Please ensure that you have 
    a localization file and an enumerations file named: #{AppConfig[:aspace_custom_localizations_default].to_s}.yml 
    in frontend/locales and frontend/locales/enums of this plugin."
  end
  
end
  