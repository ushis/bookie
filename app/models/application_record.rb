require_dependency 'bookie/search/active_record'

class ApplicationRecord < ActiveRecord::Base
  include Bookie::Search::ActiveRecord

  self.abstract_class = true

  def self.order_as_specified(definition)
    definition.reduce(self) do |scope, (attribute, values)|
      column = connection.quote_column_name(attribute)
      table = connection.quote_table_name(table_name)
      type = columns_hash[attribute.to_s].sql_type
      sql = "array_position(array[:values]::#{type}[], #{table}.#{column})"
      scope.order(sanitize_sql([sql, values: values]))
    end
  end
end
