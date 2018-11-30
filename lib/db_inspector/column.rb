module DbInspector
  class Column
    attr_reader :database_name, :schema_name, :table_name, :name, :owner, :data_type, :default, :nullable
    def initialize(info)
      info = info.symbolize_keys
      %i/database_name schema_name table_name name owner data_type default nullable/.each do |k|
        instance_variable_set "@#{k}", info[k]
      end
    end
  end
end
