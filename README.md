# GarbageMan

Removes outdated periodic backup files from your cloud storage bucket.

## Install

Into Gemfile from rubygems.org:

```
gem install garbageman
```

## Note

This gem assumes your filenames include a date and time e.g. backup.2015-07-07T10-32-01.tar.gz.

```
backup.$(date +'\%Y-\%m-\%dT\%H-\%M-\%S').tar.gz
```

Please use the `--dry-run` option to test your configuration before using garbageman.

## Usage

garbageman is best used as a cronjob. It assumes you have a cloud storage bucket where you store periodic backups with conventional filenames including date and time.

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

## Contributors

Many thanks to:

- [Bruno Sutic](https://github.com/bruno-)

## How to contribute

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Write your tests and check everything passes
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request (into the master branch)

## License

Please refer to [LICENSE.md](https://github.com/idealprojectgroup/garbageman/blob/master/LICENSE).
