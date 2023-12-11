# ArchivesSpace Custom Localizations

## About

An ArchivesSpace plugin that allows staff users to add one or more custom localizations.

You can use this both as a way to provide users with additional language options in your
local instance of ArchivesSpace and as a way to test those localizations for future 
incorporation into the core code.

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
use your custom localizations. The files are technically all optional, but will result 
in `translation missing` warnings if not present and may cause your language option to 
be unavailable.

```
common
frontend
public
```

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

Note that the labels/keys must remain in English and should be the same set as found in 
any of the core localizations for the version of ArchivesSpace that you are currently 
running.

The plugin checks for the existence of these files and *only* updates the default language 
option(s) if they are present.

### Report Localizations (optional)

The plugin also supports custom report localizations. For ease of contributing these to core,
place them in the same structure as found in core. Core localizations for reports
typically nest in a directory structure: `reports/{REPORT_GROUP}/{REPORT_NAME}/{LANGUAGE}.yml`

## Uninstalling

If you choose to uninstall this plugin and any users have chosen a custom localization that 
is *not* a core localization, you *must* first set the `Language Selection` in Preferences 
for any users with that custom locale to a core locale or the application will fail to render
for those users.

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