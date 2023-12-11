# we override the default locales available

locale_enum = I18n::LOCALES.dup

class AspaceCustomLocalesSchema
  @plugin_dir = nil

  ASUtils.find_local_directories.each do |plugin_dir|
    if File.exist?(File.join(plugin_dir, 'has_custom_locales.txt'))
      @plugin_dir = plugin_dir
    end
  end

  def self.plugin_dir
    @plugin_dir
  end

  def self.allow_locale?(lang)
    # for this case, we only need to check the frontend since that's where the defaults are used
    locale = File.join(@plugin_dir, "frontend", "locales", "#{lang.to_s}.yml")
    enum = File.join(@plugin_dir, "frontend", "locales", "enums", "#{lang.to_s}.yml")

    return (File.exist?(locale) && File.exist?(enum))
  end
end
  
if AppConfig.has_key?(:aspace_custom_localizations) && !AspaceCustomLocalesSchema.plugin_dir.nil?
  AppConfig[:aspace_custom_localizations].each do |loc, lang|
    if AspaceCustomLocalesSchema.allow_locale?(loc)
      locale_enum[loc] = lang
    end
  end
end

{
  "locale" => {
    "type" => "string",
    "enum" => locale_enum,
    "required" => false,
  }
}