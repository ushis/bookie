module Bookie
  class Endpoint < Dry::Matcher
    class_attribute :endpoints, instance_accessor: false
    self.endpoints = {}

    def self.endpoint(name, func)
      self.endpoints = endpoints.merge({
        name => Dry::Matcher::Case.new(match: func),
      })
    end

    def self.call(result, &block)
      new.(result, &block)
    end

    def initialize
      super(self.class.endpoints)
    end
  end
end
