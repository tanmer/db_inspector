require 'active_record'
module DbInspector
  module Connection
    def self.establish_connection(config='postgres://postgres:@localhost:5432/postgres', logger=nil)
      resolver = ActiveRecord::ConnectionAdapters::ConnectionSpecification::Resolver.new({})
      spec = resolver.spec(config)

      k = Class.new do
        include ActiveRecord::ConnectionHandling
        attr_reader :logger
        def initialize(logger)
          @logger = logger
        end
      end.new(logger)

      connection = k.send(spec.adapter_method, spec.config)
      connection.send :extend, CommonMethods
      connection.send :extend, "DbInspector::Adapters::#{spec.config[:adapter].camelize}".constantize
      connection
    end

    module CommonMethods

      def inspect
        "#{adapter_name}: (#{@config})"
      end

      alias_method :to_s, :inspect

      def config
        @config
      end

      def switch_db!(database_name)
        disconnect!
        clear_cache!
        @config.update database: database_name
        @connection_parameters.update dbname: database_name
        connect
        self
      end

      def databases
        raise "have to define how to get databases in adapter."
      end

      def schemas
        raise "have to define how to get schemas in adapter."
      end

    end
  end
end
