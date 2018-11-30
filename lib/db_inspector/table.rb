module DbInspector
  class Table
    attr_reader :name, :owner, :schema_name, :database_name
    def initialize(info)
      info = info.symbolize_keys
      %i/name owner schema_name database_name/.each do |k|
        instance_variable_set "@#{k}", info[k]
      end
    end
  end
end
