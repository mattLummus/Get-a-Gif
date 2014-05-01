require "sqlite3"

class App

  def initialize(*args)
    input = args[0]

    #Open a database
    db = SQLite3::Database.new('gifs.db')
    #db.execute "CREATE TABLE IF NOT EXISTS Gifs(id INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT, category TEXT, emotion TEXT, reference TEXT)"
    db.execute "CREATE TABLE IF NOT EXISTS Gifs(url TEXT, category TEXT, emotion TEXT, reference TEXT)"

    if input[0] == "give"
      puts "give a gif"
      url = input[1].dup
      category = input[2]
      emotion = input[3]
      reference = input[4]
      db.execute "INSERT INTO Gifs VALUES('#{url}', '#{category}', '#{emotion}', '#{reference}')"

    elsif input[0] == "get"
      puts "get a gif"
      link = 'https://i.imgur.com/LsglmGb.gif'
      stm = db.prepare "SELECT url FROM Gifs LIMIT 5"
      rs = stm.execute
      rs.each do |row|
        row = row.to_s
        row.gsub!("[", '')
        row.gsub!("]", '')
        IO.popen('open -a Google\ Chrome '+row, 'r+') do |pipe|
          pipe.close_write
        end #of IO
      end
    else
      puts "There was an error in your request."
      puts "Try one of these requests:"
      puts "./giffer give url.gif (to insert a new gif)"
      puts "./giffer get (to receive an old gif)"
    end #of input check

  end #of initialize

end #of class

gif_app = App.new(ARGV)
