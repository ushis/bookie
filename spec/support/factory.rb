class Factory
  class_attribute :_key, instance_accessor: false
  class_attribute :_befores, instance_accessor: false
  class_attribute :_operation, instance_accessor: false
  class_attribute :_params, instance_accessor: false
  class_attribute :_properties, instance_accessor: false
  class_attribute :_dependencies, instance_accessor: false

  class << self
    def befores
      self._befores ||= []
    end

    def params
      self._params ||= []
    end

    def properties
      self._properties ||= []
    end

    def dependencies
      self._dependencies ||= []
    end

    def param(name, func)
      params.push(name)
      define_reader(name, func)
    end

    def property(name, func)
      properties.push(name)
      define_reader(name, func)
    end

    def dependency(name, func)
      dependencies.push(name)
      define_reader(name, func)
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

    private

    def define_reader(name, func)
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
  end

  def initialize(params={}, dependencies={})
    @params = params
    @dependencies = dependencies
  end

  def properties
    self.class.properties.map { |name| [name, send(name)] }.to_h
  end

  def params
    property_params.deep_merge(param_params)
  end

  def dependencies
    (self.class.dependencies - @dependencies.keys).map { |name|
      [name, send(name)]
    }.to_h.deep_merge(@dependencies)
  end

  def create
    self.class.befores.each { |block| instance_exec(&block) }
    self.class._operation.(params, dependencies)['model']
  end

  private

  def property_params
    self.class._key.nil? ? properties : {self.class._key => properties}
  end

  def param_params
    (self.class.params - @params.keys).map { |name|
      [name, send(name)]
    }.to_h.deep_merge(@params)
  end
end
