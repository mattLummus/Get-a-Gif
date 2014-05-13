require 'database'
require 'environment'
require 'active_record'
class Gif < ActiveRecord::Base
  attr_reader :errors
  attr_reader :id
  attr_accessor :url
  attr_accessor :emotion
  attr_accessor :reference

  def initialize(url, emotion, reference)
    @url = url
    @emotion = emotion
    @reference = reference
  end

  def self.all
    statement = "Select * from gifs;"
    execute_and_instantiate(statement)
  end

  def self.all_tags(tag)
    statement = "Select #{tag} from gifs;"
    execute_and_instantiate(statement)
  end

  def self.full_query(emotion, reference)
    statement = "Select url from gifs where emotion = '#{emotion}' AND reference = '#{reference}'"
    execute_and_instantiate(statement)
  end

  def self.backup_query(type, tag)
    statement = "Select url from gifs where #{type} = '#{tag}'"
    execute_and_instantiate(statement)
  end

  def self.count
    statement = "Select count(*) from gifs;"
    result = Environment.database_connection.execute(statement)
    result[0][0]
  end

  def self.create(url, emotion, reference)
    gif = Gif.new(url, emotion, reference)
    gif.save
    gif
  end

  #returns an array
  def self.find_by_tag(tag_type, tag_value)
    statement = "Select * from gifs where #{tag_type} = ?;"
    execute_and_instantiate(statement, tag_value)
  end

  def self.last
    statement = "Select * from gifs order by id DESC limit(1);"
    execute_and_instantiate(statement)[0]
  end

  def save
      statement = "Insert into gifs (url, emotion, reference) values ('#{url}', '#{emotion}', '#{reference}');"
      Environment.database_connection.execute(statement)
      @id = Environment.database_connection.execute("SELECT last_insert_rowid();")[0][0]
      true
  end

=begin
  def valid?
    @errors = []
    if !name.match /[a-zA-Z]/
      @errors << "'#{self.name}' is not a valid injury name, as it does not include any letters."
    end
    if Injury.find_by_name(self.name)
      @errors << "#{self.name} already exists."
    end
    @errors.empty?
  end
=end

  private

  def self.execute_and_instantiate(statement, bind_vars = [])
    rows = Environment.database_connection.execute(statement, bind_vars)
    results = []
    rows.each do |row|
      gif = Gif.new(row["url"], row["emotion"], row["reference"])
      gif.instance_variable_set(:@id, row["id"])
      results << gif
    end
    results
  end

end
