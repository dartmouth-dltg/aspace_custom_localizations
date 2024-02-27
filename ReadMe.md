# ArchivesSpace Custom Localizations

## About

An ArchivesSpace plugin that allows the use of one or more custom localizations.

You can use this both as a way to provide users with additional language options in your
local instance of ArchivesSpace and as a way to test those localizations for future 
incorporation into the core code.

Note the important instructions about [Setting User Preferences](#setting-user-preferences)
and [Uninstalling](#uninstalling).

Note about [Bulk Importer Workaround](#bulk-importer-workaround).

ArchivesSpace encourages users who have developed additional localizations to contribute
those to the core code.

## Getting started

Enable the plugin by editing your ArchivesSpace configuration file
(`config/config.rb`):

```
  AppConfig[:plugins] = ['other_plugin', 'aspace_custom_localizations']
```

(Make sure you uncomment this line (i.e., remove the leading '#' if present))

## Configuration

This plugin adds three configuration options. Add these to your config.rb file

`AppConfig[:aspace_custom_localizations]` should be a hash that maps one or more
I18n language codes to the related ArchivesSpace enumerations:language_iso639_2 code.
Enumerations iso codes are found in `common/locales/enums`.

### Single localization example (Dutch)

```
AppConfig[:aspace_custom_localizations] = {
  'nl' => 'dut'
}
```

### Multiple localization example (Dutch and Italian)

```
AppConfig[:aspace_custom_localizations] = {
  'nl' => 'dut',
  'it' => 'ita'
}
```

Then you can choose a default language for the frontend (staff app) and PUI. 
Set `AppConfig[:aspace_custom_localizations_default]` and/or 
`AppConfig[:aspace_custom_localizations_public_default]`
to one of the new localizations.

### Example
```
AppConfig[:aspace_custom_localizations_default] = :nl
AppConfig[:aspace_custom_localizations_public_default] = :nl
```

## Localization files

You *must* place new localization files in the appropriate locations if you wish to 
use your custom localizations.

The file names *must* match the default language you chose. For example, if you chose 
Dutch as your default language, and wish to change both the frontend and PUI, add files 
named `nl.yml` to both locations in addition to those placed in `common`. If you only 
wish to change the staff interface, you would only need the `common` and `frontend` 
localization files.

A example set of custom localization files for Dutch:

```
common/locales/nl.yml
common/locales/enums/nl.yml
frontend/locales/nl.yml
public/locales/nl.yml
```

Note that the labels/keys for your new localizations *must* remain as they are found in
the core localizations for the version of ArchivesSpace that you are currently running.

The plugin checks for the existence of these files and *only* updates the default language 
option(s) if they are present.

### Report Localizations (optional)

The plugin also supports custom report localizations. For ease of contributing these to core,
place them in the same structure as found in core. Core localizations for reports
typically nest in a directory structure: `reports/{REPORT_GROUP}/{REPORT_NAME}/{LANGUAGE}.yml`

### Third Party Plugin Localizations

Some plugins may not provide fallback translation options and may present the standard
"We're sorry, but something went wrong." error message if instantiated with a non-core
localization. In such cases, make sure to add additional plugin specific localizations to your
custom localization files.

For example, the `as_history` plugin provided by the 
(Queensland State Archives)[https://gitlab.gaiaresources.com.au/qsa/as_history] does not provide
translations for any language other than English.

### Fallbacks

The plugin will set the fallback language to the *initial default locale* for both the staff 
interface and the PUI. Any missing translations in your custom localization will fall back to
one found in the default localization (one of the core localizations). 

## Setting User Preferences

A user's preference for their chosen language will *not* be overriden by the plugin settings and
will remain set to the language chosen prior to installing this plugin. Users will need to
update their preferred language in `Preferences` if they wish to use one of the new localizations.

### Default Preferences

Default preferences remain untouched since these are built during the first startup of the
application and *must* include *only* core localizations as they will always be available, while
custom localizations may not.

## Bulk Importer Workaround

The bulk importer will fail to validate certain elements (enumerations, etc) if localizations are used.
To work around this, use the enumeration keys as the value in the bulk import spreadsheet.
For example, instead of the custom localization for `Series`, use the enumeration key `series` in the
archival record level column.

## Uninstalling

If you choose to uninstall this plugin and any users have chosen a custom localization that 
is *not* a core localization, you *must* first set the `Language Selection` in `Preferences`
for any users with that custom locale to a core locale or the application will fail to render
for those users. Those users will see the standard "We're sorry, but something went wrong."
error message.

If your custom localization has become part of the core localizations, you can safely remove
this plugin without any additional action.

## Core Overrides

This plugin overrides the following method in `frontend/plugin_init.rb`

```
ApplicationHelper.supported_locales_options
```

It also extends/overrides the `defaults` schema. See `schemas/defaults_ext.rb`

## Credits

Plugin developed by Joshua Shaw [Joshua.D.Shaw@dartmouth.edu], Digital Library Technologies Group
Dartmouth Library, Dartmouth College
