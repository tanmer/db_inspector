module DbInspector
  module Adapters
    module Postgresql

      def databases
        sql = <<-SQL
          SELECT
            datname as name,
            pg_authid.rolname as owner,
            pg_encoding_to_char(encoding) as encoding,
            datcollate as collate,
            datctype as ctype
          FROM pg_database
          JOIN pg_authid ON pg_database.datdba = pg_authid.oid
          WHERE datistemplate = false;
        SQL
        select_all(sql).map{ |row| DbInspector::Database.new(row) }
      end

      def schemas
        sql = <<-SQL
          SELECT
            catalog_name as database_name,
            schema_name as name,
            schema_owner as owner
          FROM information_schema.schemata
        SQL
        select_all(sql).map{ |row| DbInspector::Schema.new(row) if row['name'] != 'information_schema' && row['name'] !~ /^pg_/ }.compact
      end

      def tables(schema_name:)
        sql = <<-SQL
          SELECT
            current_database() as database_name,
            schemaname as schema_name,
            tablename as name,
            tableowner as owner
          FROM pg_tables
          WHERE
            schemaname = '#{schema_name}'
        SQL
        select_all(sql).map{ |row| DbInspector::Table.new(row) }
      end

      def columns(table_name:, schema_name:)
        sql = <<-SQL
          SELECT
            current_database() as database_name,
            table_schema as schema_name,
            table_name as table_name,
            column_name as name,
            column_default as default,
            is_nullable = 'YES' as nullable,
            udt_name as data_type
          FROM information_schema.columns
          WHERE
            table_schema = '#{schema_name}' AND
            table_name   = '#{table_name}'
        SQL
        select_all(sql).map{ |row| DbInspector::Column.new(row) }
      end

    end
  end
end
