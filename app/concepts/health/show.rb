require_dependency 'bookie/operation'
require_dependency 'health/check/database'
require_dependency 'health/check/elasticsearch'
require_dependency 'health/check/s3'
require_dependency 'health/check/sidekiq'
require_dependency 'health/system'

module Health
  class Show < Bookie::Operation
    step :system!

    def system!(options, **)
      options['system'] = System.new({
        s3: Check::S3.new,
        sidekiq: Check::Sidekiq.new,
        database: Check::Database.new,
        elasticsearch: Check::Elasticsearch.new,
      })
    end
  end
end
