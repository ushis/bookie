require 'reform/form/dry'
require 'reform/form/coercion'
require 'disposable/twin/property/struct'

module Bookie
  class Contract < Reform::Form
    feature Dry
    feature Coercion

    module Types
      module Form
        include Dry::Types.module

        Str = String.constructor { |str| str.nil? ? str : str.strip }
      end
    end
  end
end
