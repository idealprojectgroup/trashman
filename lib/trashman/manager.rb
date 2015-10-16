require 'fog'
require 'trashman'

module TrashMan
  class Manager
    def initialize(provider, options = {})
      @options = options

      @connection = Fog::Storage.new(
        { provider: provider }.merge(options[:credentials])
      )
    end

    def cleanup!(&block)
      queued_files.each do |file|
        yield(file) if block

        if !options[:dry_run]
          file.destroy
        end
      end

      queued_files.count
    end

  private

    def options
      @options
    end

    def connection
      @connection
    end

    def container
      @container ||= connection.directories.get(options[:container])
    end

    def files
      @files ||= container.files.sort_by { |file| file.key }
    end

    def queued_files
      files[0...(- options[:keep])]
    end

  end
end
