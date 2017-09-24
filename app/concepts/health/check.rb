module Health
  class Check
    attr_reader :error

    def initialize
      call
    end

    def healthy?
      @error.nil?
    end
  end
end
