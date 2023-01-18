# docker-loomio-gcs

This image aims to be the exact same image as the official one but we make the
necessary changes to allow using GCS instead of S3 or Disk for active_storage
files.

## Needed env vars

* `credentials.json`: The credentials file in json format (in the root of the
    project `/loomio/credentials.json`)
* `GCS_PROJECT`: The project name (eg. `my-project-12345`)
* `GCS_BUCKET`: The bucket name (eg. `loomio-files`)
* `ACTIVE_STORAGE_SERVICE`: This is not a new env var, but needs to have the
    value `google` for this to work.
    
## Migrating old files into GCS

This only requires uploading the files to GCS, there the directory structure
is different, instead of `/storage/ab/cd/abcde000000` we need `/abcde000000`.

We can do that with this simple script:

```sh
fd --type f | parallel gsutil cp {.} gs://loomio-uploads/
```

And the we need to update our blobs on the db, since they have stored which
service was used to upload them in the column `service_name`.

That can be done running this on the db:

``` sql
UPDATE active_storage_blobs SET service_name = 'google';
```

