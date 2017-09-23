module Bookie
  class S3

    def initialize(options={})
      @options = options

      create_bucket
    end

    def write(content, _options={})
      uid = SecureRandom.uuid

      s3.put_object({
        acl: acl,
        bucket: bucket,
        key: uid,
        body: content.file,
        metadata: content.meta.merge({
          mime_type: content.mime_type,
        }),
      })

      uid
    end

    def read(uid)
      object = s3.get_object(bucket: bucket, key: uid)
      [object.body.read, object.metadata]
    rescue Aws::S3::Errors::NoSuchKey
      nil
    end

    def destroy(uid)
      s3.delete_object(bucket: bucket, key: uid)
      true
    rescue Aws::S3::Errors::NoSuchKey
      false
    end

    def url_for(uid, _options={})
      "#{@options.fetch(:url_host)}/#{bucket}/#{uid}"
    end

    private

    def s3
      @s3 ||= Aws::S3::Client.new(@options.fetch(:credentials))
    end

    def bucket
      @options.fetch(:bucket)
    end

    def acl
      @options[:acl]
    end

    def create_bucket
      s3.create_bucket({
        bucket: bucket,
        acl: acl,
      })
    rescue Aws::S3::Errors::BucketAlreadyOwnedByYou
      false
    end
  end
end
