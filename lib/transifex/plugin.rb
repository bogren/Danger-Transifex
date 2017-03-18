module Danger
  # Plugin to push Transifex translations
  #
  # @example Pushes your source language translations
  #
  # made_translation_changes = git.modified_files.include?("path/to/translations.strings")
  # if made_translation_changes
  #     transifex.configure("your_project", "your_resource")
  #     transifex.push_source("STRINGS", "path/to/translations.strings")
  # end
  #
  # @see  Emil Bogren/danger-transifex
  # @tags translations, transifex
  #
  class DangerTransifex < Plugin

    # Configure the Transifex client with your project name and resource.
    # The resource is a single source of translations.
    def configure(project_name, resource_name)
      require 'transifex'
      Transifex.configure do |c|
        c.client_login = ENV['TRANSIFEX_API']
        c.client_secret = ENV['TRANSIFEX_API_TOKEN']
      end

      @project = Transifex::Project.new(project_name)
      @resource = @project.resource(resource_name)
    end

    # Push the source language file to transifex, please note the source
    # is the only allowed resource to use with this method.
    def push_source(type, source)
      unless @resource.nil?
        begin
          message("Translations changed - pushing changes to Transifex")
          @resource.content.update({:i18n_type => type, :content => source})
          message("Translations updated \u{2705}")
        rescue
          warn("Updating translations failed \u{274C}")
        end
      end
    end
  end
end
