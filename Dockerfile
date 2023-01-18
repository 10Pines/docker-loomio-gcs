ARG  LOOMIO_VERSION
FROM loomio/loomio:${LOOMIO_VERSION}

RUN echo 'gem "google-cloud-storage", "~> 1.11"' >> Gemfile && \
    echo '' >> config/storage.yml && \
    echo 'google:' >> config/storage.yml && \
    echo '  service: GCS' >> config/storage.yml && \
    echo '  credentials: <%= Rails.root.join("credentials.json") %>' >> config/storage.yml && \
    echo '  project: <%= ENV["GCS_PROJECT"] %>' >> config/storage.yml && \
    echo '  bucket: <%= ENV["GCS_BUCKET"] %>' >> config/storage.yml && \
    bundle install
