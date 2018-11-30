module DbInspector
  class Database
    attr_reader :name, :encoding, :owner, :collate, :ctype, :connection

    def initialize(info)
      info = info.symbolize_keys
      %i/name encoding owner collate ctype/.each do |k|
        instance_variable_set "@#{k}", info[k]
      end
    end

    def inspect
      "Database: (#{name}, #{connection || 'Unconnected'})"
    end

    def connect!(config, logger: nil)
      connection.disconnect! if connection
      @connection = DbInspector::Connection.establish_connection(config.merge(database: name), logger)
      self
    end

    def schemas
      connection.schemas
    end

    def tables(schema_name:)
      connection.tables(schema_name: schema_name)
    end

    def columns(schema_name:, table_name:)
      connection.columns(table_name: table_name, schema_name: schema_name)
    end

  end
end
