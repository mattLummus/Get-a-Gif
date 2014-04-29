require "sqlite3"

class App

  def initialize(*args)
    input = args[0]

    #Open a database
    db = SQLite3::Database.new('gifs.db')
    db.execute "CREATE TABLE IF NOT EXISTS Gifs(id INTEGER PRIMARY KEY,
        url TEXT, category TEXT, emotion TEXT, reference TEXT)"

    if input[0] == "give"
      puts "give a gif"
      id = (db.last_insert_row_id + 1)# || 1
      url = input[1].dup
      category = input[2]
      emotion = input[3]
      reference = input[4]
      #db.execute "INSERT INTO Gifs VALUES (#{id}, #{url}, #{category}, #{emotion}, #{reference})"
      puts "INSERT INTO Gifs VALUES (#{id}, #{url}, #{category}, #{emotion}, #{reference})"

    elsif input[0] == "get"
      puts "give a gif"
      link = 'https://i.imgur.com/LsglmGb.gif'
      IO.popen('open -a Google\ Chrome '+link, 'r+') do |pipe|
        pipe.close_write
      end #of IO

    else
      puts "There was an error in your request."
      puts "Try one of these requests:"
      puts "./giffer give url.gif (to insert a new gif)"
      puts "./giffer get (to receive an old gif)"
    end #of input check

  end #of initialize

end #of class

gif_app = App.new(ARGV)
