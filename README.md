# Danger Transifex

A [Transifex](https://www.transifex.com/) plugin to use with danger. Allows you to push your source language to Transifex if there are changes. Note that you have to setup Transifex before you can use this plugin.

## Installation

    $ gem install danger-transifex

Make sure to set the ENV variables to either use an api token or you credentials, see [transifex docs](https://docs.transifex.com/api/introduction) for more info.

## Usage

Example

    made_translation_changes = git.modified_files.include?("path/to/translations.strings")
    if made_translation_changes
        transifex.configure("your_project", "your_resource")
        transifex.push_source("STRINGS", "path/to/translations.strings")
    end

## Development

1. Clone this repo
2. Run `bundle install` to setup dependencies.
3. Run `bundle exec rake spec` to run the tests.
4. Use `bundle exec guard` to automatically have tests run as you make changes.
5. Make your changes.
