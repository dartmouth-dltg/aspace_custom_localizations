 require 'i18n'

 class AspaceCustomLocalesHelper

  def self.check_locales_exist(loc, lang, plugin_dir)
    locale = File.join(plugin_dir, loc, "locales", "#{lang.to_s}.yml")
    enum = File.join(plugin_dir, loc, "locales", "enums", "#{lang.to_s}.yml")

    return (File.exist?(locale) && File.exist?(enum))
  end

  def self.allow_frontend_locale?(lang, plugin_dir)
    check_locales_exist('frontend', lang, plugin_dir)
  end

  def self.allow_public_locale?(lang, plugin_dir)
    check_locales_exist('public', lang, plugin_dir)
  end

  def self.allow_locale?(lang, plugin_dir)
    return self.allow_frontend_locale?(lang, plugin_dir) && self.allow_public_locale?(lang, plugin_dir)
  end

  def self.custom_locales_exist?(lang, plugin_dir)
    check_locales_exist('common', lang, plugin_dir)
  end

  def self.check_default_locale_existence(plugin_dir)
    self.allow_frontend_locale?(AppConfig[:aspace_custom_localizations_default].to_s, plugin_dir)
  end

  def self.check_default_public_locale_existence(plugin_dir)
    self.allow_public_locale?(AppConfig[:aspace_custom_localizations_public_default].to_s, plugin_dir)
  end

end
