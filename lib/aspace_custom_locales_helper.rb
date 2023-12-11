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

end
