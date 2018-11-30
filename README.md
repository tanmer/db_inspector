# DbInspector

数据库结构审查工具，可获取以下数据：

- database
- schema
- table
- column

## Usage

```ruby
config = {
  :adapter=>"postgresql",
  :username=>"postgres",
  :port=>5432,
  :database=>"postgres",
  :host=>"localhost"
}
conn = DbInspector::Connection.establish_connection(config)
# => PostgreSQL: ({:adapter=>"postgresql", :username=>"postgres", :port=>5432, :database=>"postgres", :host=>"localhost"})
conn.databases
# => [Database: (postgres, Unconnected)]
db = conn.databases.last
# => Database: (postgres, Unconnected)
db.connect! config
# => Database: (postgres, PostgreSQL: ({:adapter=>"postgresql", :username=>"postgres", :port=>5432, :database=>"postgres", :host=>"localhost"}))
db.schemas
# => [#<DbInspector::Schema:0x00007fe59a6d0128 @database_name="postgres", @name="public", @owner="postgres">]
db.tables(schema_name: 'public')
=> [#<DbInspector::Table:0x00007fe59badc270 @database_name="postgres", @name="t1", @owner="postgres", @schema_name="public">]
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'db_inspector'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install db_inspector
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
