module DbInspector
  class Schema
    attr_reader :name, :owner, :database_name
    def initialize(info)
      info = info.symbolize_keys
      %i/name owner database_name/.each do |k|
        instance_variable_set "@#{k}", info[k]
      end
    end
  end
end
