Dragonfly::App.register_datastore(:s3) { Bookie::S3 }

Dragonfly.app.configure do
  plugin :imagemagick

  secret Rails.application.secrets.dragonfly

  datastore :s3, {
    url_host: ENV.fetch('S3_URL_HOST', ENV['S3_ENDPOINT']),
    bucket: ENV['S3_BUCKET'],
    acl: ENV.fetch('S3_ACL', 'public-read'),
    credentials: {
      endpoint: ENV['S3_ENDPOINT'],
      access_key_id: ENV['S3_ACCESS_KEY'],
      secret_access_key: ENV['S3_SECRET_KEY'],
      region: ENV.fetch('S3_REGION', 'us-east-1'),
      force_path_style: true,
      logger: Rails.logger,
    },
  }
end

Dragonfly.logger = Rails.logger
