 require 'i18n'

 class AspaceCustomLocalesHelper

  def self.locales_exist?(loc, lang, plugin_dir)
    File.exist?(File.join(plugin_dir, loc, "locales", "#{lang.to_s}.yml"))
  end

  def self.allow_frontend_locale?(lang, plugin_dir)
    return locales_exist?('frontend', lang, plugin_dir) && custom_common_locales_exist?(lang, plugin_dir)
  end

  def self.allow_public_locale?(lang, plugin_dir)
    return locales_exist?('public', lang, plugin_dir) && custom_common_locales_exist?(lang, plugin_dir)
  end

  def self.allow_locale?(lang, plugin_dir)
    return self.allow_frontend_locale?(lang, plugin_dir) && self.allow_public_locale?(lang, plugin_dir)
  end

  def self.custom_common_locales_exist?(lang, plugin_dir)
    locale = locales_exist?('common', lang, plugin_dir)
    enum = File.exist?(File.join(plugin_dir, "common", "locales", "enums", "#{lang.to_s}.yml"))

    return locale && enum
  end

  def self.default_locale_exist?(plugin_dir)
    self.allow_frontend_locale?(AppConfig[:aspace_custom_localizations_default].to_s, plugin_dir)
  end

  def self.default_public_locale_exist?(plugin_dir)
    self.allow_public_locale?(AppConfig[:aspace_custom_localizations_public_default].to_s, plugin_dir)
  end

  def self.set_locale(app_name, plugin_dir, config)
    localization = AppConfig[:aspace_custom_localizations_default]

    allow_locale = false

    if ['backend', 'frontend'].include?(app_name)
      localization = AppConfig[:aspace_custom_localizations_default]
      allow_locale = allow_frontend_locale?(localization, plugin_dir)
      app_dir = 'frontend'
    elsif app_nane = 'public'
      localization = AppConfig[:aspace_custom_localizations_public_default]
      allow_locale = allow_public_locale?(localization, plugin_dir)
      app_dir = 'public'
    end

    if allow_locale

      if app_name == 'backend'
        I18n::Backend::Simple.include(I18n::Backend::Fallbacks)
        I18n.fallbacks = I18n::Locale::Fallbacks.new(de: :en, es: :en, fr: :en, ja: :en, localization.to_s => :en)
      else
        config.i18n.fallbacks = [AppConfig[:locale]]
      end
      AppConfig[:locale] = localization
      if app_name == 'backend'
        I18n.default_locale = AppConfig[:locale]
      else
        config.i18n.default_locale = AppConfig[:locale]
      end
      region = I18n.t('enumerations.country_iso_3166.' + localization.to_s.upcase)
      language = I18n.t('enumerations.language_iso639_2.' + AppConfig[:aspace_custom_localizations][localization.to_s])

      puts "\n\nAspace Custom Locales Plugin:
      Default #{app_name.capitalize} locale set to custom locale: #{AppConfig[:locale]} 
      for country/region: #{region}
      with language: #{language}.\n\n"
    else  
      puts "\n\nAspace Custom Locales Plugin:
      WARNING - #{app_name.capitalize} localization files for the selected default language do not exist.
      Please ensure that you have localization files named: #{localization.to_s}.yml 
      in #{app_dir}/locales, common/locales, and common/locales/enums of this plugin.\n\n"
    end

  end

end
