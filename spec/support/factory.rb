class Factory
  class_attribute :_key, instance_accessor: false
  class_attribute :_befores, instance_accessor: false
  class_attribute :_operation, instance_accessor: false
  class_attribute :_properties, instance_accessor: false
  class_attribute :_dependencies, instance_accessor: false

  class << self
    def befores
      self._befores ||= []
    end

    def properties
      self._properties ||= []
    end

    def dependencies
      self._dependencies ||= {}
    end

    def property(name, func)
      properties.push(name)

      define_singleton_method(name) {
        func.()
      }

      define_method(name) {
        if instance_variable_defined?("@#{name}")
          instance_variable_get("@#{name}")
        else
          value = instance_exec(&func)
          instance_variable_set("@#{name}", value)
          value
        end
      }
    end

    def dependency(name, func)
      dependencies[name] = func
    end

    def before(&block)
      befores.push(block)
    end

    def key(key)
      self._key = key
    end

    def operation(operation)
      self._operation = operation
    end

    def create(attributes={}, dependencies={})
      new(attributes, dependencies).create
    end
  end

  def initialize(attributes={}, dependencies={})
    @attributes = attributes
    @dependencies = dependencies
  end

  def attributes
    (self.class.properties - @attributes.keys).map { |name|
      [name, send(name)]
    }.to_h.merge(@attributes)
  end

  def params
    self.class._key.nil? ? attributes : {self.class._key => attributes}
  end

  def dependencies
    (self.class.dependencies.keys - @dependencies.keys).map { |name|
      [name, self.class.dependencies[name].()]
    }.to_h.merge(@dependencies)
  end

  def create
    self.class.befores.each { |block| instance_exec(&block) }
    self.class._operation.(params, dependencies)['model']
  end
end
