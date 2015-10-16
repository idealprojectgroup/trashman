require 'thor'
require 'garbage_man'
require 'garbage_man/manager'

module GarbageMan
  class CLI < ::Thor

    desc "prune", "Prunes old backups."
    method_option :provider, type: :string, aliases: %w(-P),
      required: true,
      desc: "A valid fog provider e.g. rackspace, aws, etc."
    method_option :container, type: :string, aliases: %w(-c),
      required: true,
      desc: "Container or bucket on fog provider."
    method_option :keep, type: :numeric, aliases: %w(-k),
      default: 100,
      desc: "Number of files to keep."
    method_option :credentials, type: :hash, required: true,
      desc: "Credentials for your fog provider (depends on fog provider)."
    method_option :dry_run, type: :boolean, default: false,
      desc: "As normal, but it does not destroy old backups."
    def prune
      if options.dry_run
        say "This is a dry-run. No files will be deleted."
      end

      manager = GarbageMan::Manager.new(options.provider, options)
      count = manager.cleanup! do |file|
        say " -- deleting #{file.key}", :yellow
      end

      if options.dry_run
        say "This was a dry-run. No files were deleted."
      else
        say "#{count} file(s) deleted.", :green
      end
    # This seems dirty.
    # However, if the Fog::Storage provider throws any error,
    # the user will be notified. Errors can be related to
    # authentication, nonexistent bucket, etc.
    rescue => e
      say e.message
    end

  end
end
