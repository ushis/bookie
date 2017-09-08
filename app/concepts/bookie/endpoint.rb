module Bookie
  class Endpoint < Dry::Matcher
    class_attribute :endpoints, instance_accessor: false

    def self.endpoint(name, func)
      self.endpoints ||= {}
      self.endpoints[name] = Dry::Matcher::Case.new(match: func)
    end

    def self.call(result, &block)
      new.(result, &block)
    end

    def initialize
      super(self.class.endpoints)
    end
  end
end
