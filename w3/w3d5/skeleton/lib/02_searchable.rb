require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    cols = params.keys.map { |col| "#{col} = ?" }.join(" AND ")
    results = DBConnection.execute(<<-SQL, params.values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{cols}
    SQL
    results.map do |result|
      self.new(result)
    end
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
