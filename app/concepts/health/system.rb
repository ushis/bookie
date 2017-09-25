module Health
  class System
    attr_reader :checks

    def initialize(checks)
      @checks = checks
    end

    def healthy?
      checks.values.all?(&:healthy?)
    end

    # FIXME: move to serializer
    def to_h
      {status: overall_status, checks: individual_statuses}
    end

    private

    def overall_status
      healthy? ? 'ok' : 'critical'
    end

    def individual_statuses
      checks.map { |key, check|
        [key, check.healthy? ? 'ok' : "critical: #{check.error}"]
      }.to_h
    end
  end
end
