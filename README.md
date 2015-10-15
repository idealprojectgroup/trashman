# GarbageMan

Removes outdated periodic backup files from your cloud storage bucket.

## Install

Into Gemfile from rubygems.org:

```
gem install garbageman
```

## Note

This gem assumes your filenames include a date and time e.g. backup-file.2015-07-07T10-32-01.tgz.

Please use the `--dry-run` option to test your configuration before using garbageman.

## Usage

To destroy outdated backups:

```
garbageman prune --provider <FOG PROVIDER> --keep <NUMBER OF FILES TO KEEP> --container <CONTAINER/BUCKET> --credentials username:<USERNAME> password:<PASSWORD>

garbageman prune --provider rackspace --keep 100 --container "Test Container" --credentials rackspace_api_key:abc123 rackspace_username:example rackspace_region:ord

garbageman help prune

Usage:
  garbageman prune --credentials=key:value -P, --provider=PROVIDER -c, --container=CONTAINER

Options:
  -P, --provider=PROVIDER          # A valid fog provider e.g. rackspace, aws, etc.
  -c, --container=CONTAINER        # Container or bucket on fog provider.
  -k, [--keep=N]                   # Number of files to keep.
                                   # Default: 100
      --credentials=key:value      # Credentials for your fog provider (depends on fog provider).
      [--dry-run], [--no-dry-run]  # As normal, but it does not destroy old backups.
```

## License

Please refer to [LICENSE.md](https://github.com/idealprojectgroup/garbageman/blob/master/LICENSE.md).
