class AspaceCustomLocalesHelper

  def self.check_locale_existence(lang, plugin_dir)
    locales = File.join(plugin_dir, "frontend", "locales", "#{lang}.yml")
    enums = File.join(plugin_dir, "frontend", "locales", "enums", "#{lang}.yml")

    return (File.exist?(locales) && File.exist?(enums))
  end

  def self.check_default_locale_existence(plugin_dir)
    self.check_locale_existence(AppConfig[:aspace_custom_localizations_default].to_s, plugin_dir)
  end

end
