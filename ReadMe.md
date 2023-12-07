# ArchivesSpace Custom Localizations

## About

An ArchivesSpace plugin that allows staff users to add one or more custom localizations.

## Getting started

Unzip the latest relevant release (check for specific releases for specific versions 
of ArchivesSpace) of the plugin to your ArchivesSpace plugins directory:

Enable the plugin by editing your ArchivesSpace configuration file
(`config/config.rb`):

     AppConfig[:plugins] = ['other_plugin', 'aspace_custom_localizations']

(Make sure you uncomment this line (i.e., remove the leading '#' if present))

See also:

  https://github.com/archivesspace/archivesspace/blob/master/plugins/README.md

## Configuration

This plugin adds two configuration options. Add these to your config.rb file

`AppConfig[:aspace_custom_locaizations]` should be a hash that maps one or more
I18n language codes to the related ArchivesSpace enumerations:language_iso639_2 code.
Enumerations iso codes are found in common/locales/enums.

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

Then you can choose a default language. Set `AppConfig[:aspace_custom_localizations_default]`
to one of the new localizations.

```
AppConfig[:aspace_custom_localizations_default] = :nl
```

## Localization files

You *must* place new localization files in `frontend/locales` and
`frontend/locales/enums` whose file names match the default language you chose.
For example, if you chose Dutch as your default language, add files named `nl.yml` to both
locations. Note that the labels/keys must remain in English
and should be the same set as found in any of the core localizations for the version of ArchivesSpace
that you are currently running.

The pligin checks for the existence of these files and *only* updates the default language
if they are present.

## Core Overrides

This plugin overrides the following method in `frontend/plugin_init.rb`

```
ApplicationHelper.def supported_locales_options
```

It also extends/overrides the defaults schema. See `schemas/defaults_ext.rb`

## Credits

Plugin developed by Joshua Shaw [Joshua.D.Shaw@dartmouth.edu], Digital Library Technologies Group
Dartmouth Library, Dartmouth College