require "sqlite3"

class Database < SQLite3::Database
  def initialize(database)
    super(database)
    self.results_as_hash = true
  end

  def self.connection(environment)
    @connection ||= Database.new("db/get_a_gif_#{environment}.sqlite3")
  end

  def create_tables
    self.execute("CREATE TABLE gifs (id INTEGER PRIMARY KEY AUTOINCREMENT, url varchar(100), category varchar(50), emotion varchar(50), reference(50)")
    self.execute("CREATE TABLE tags (id INTEGER PRIMARY KEY AUTOINCREMENT, tag_name varchar(50), tag_type varchar(50)")
  end

  def execute(statement, bind_vars = [])
    Environment.logger.info("Executing: #{statement} with: #{bind_vars}")
    super(statement, bind_vars)
  end
end
