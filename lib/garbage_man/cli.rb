require 'garbage_man'
require 'thor'
require 'fog'

module GarbageMan
  class CLI < ::Thor

    desc "prune", "Destroy old backups."
    method_option :provider, type: :string, aliases: %w(-P),
      required: true,
      desc: "Fog provider"
    method_option :container, type: :string, aliases: %w(-c),
      required: true,
      desc: "Bucket"
    method_option :keep, type: :numeric, aliases: %w(-k),
      required: true, default: 100,
      desc: "Number of files to keep"
    method_option :credentials, type: :hash, required: true,
      desc: "Dependent on the fog provider in-use."
    method_option :dry_run, type: :boolean, default: false,
      desc: "As normal, but it does not destroy old backups."
    def prune
      connection = Fog::Storage.new(
        { provider: options.provider }.merge(options.credentials)
      )

      container = connection.directories.get(options.container)

      files = container.files

      files = files.sort_by { |f| f.key }

      if options.dry_run
        say "This is a dry-run. No files will be deleted."
      end

      queued_files = files[0...(- options.keep)]

      queued_files.each do |file|
        say " -- deleting #{file.key}", :yellow

        if !options.dry_run
          file.destroy
        end
      end

      if options.dry_run
        say "This was a dry-run. No files were deleted."
      else
        say "#{queued_files.count} file(s) deleted.", :green
      end
    rescue ArgumentError => e
      say e.message
    end

  end
end
