require_dependency 'health/check/database'
require_dependency 'health/check/elasticsearch'
require_dependency 'health/check/s3'
require_dependency 'health/check/sidekiq'

module Health
  class Show < Bookie::Operation
    COMPONENTS = [
      [:database,      Check::Database],
      [:elasticsearch, Check::Elasticsearch],
      [:s3,            Check::S3],
      [:sidekiq,       Check::Sidekiq],
    ]

    step :checks!
    step :status!
    step :details!
    step :health!

    def checks!(options, **)
      options['checks'] = COMPONENTS.map { |name, check| [name, check.new] }
    end

    def status!(options, checks:, **)
      options['status'] = checks.map(&:last).all?(&:healthy?) ? 'ok' : 'critical'
    end

    def details!(options, checks:, **)
      options['details'] = checks.map { |name, check|
        [name, check.healthy? ? 'ok' : "critical: #{check.error}"]
      }
    end

    def health!(options, status:, details:, **)
      options['health'] = {status: status, components: details.to_h}
    end
  end
end
