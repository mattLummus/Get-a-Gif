##!/usr/bin/env ruby

class App

  def initialize(*args)
    input = args[0]

    if input[0] == "give"
      url = input[0].dup
      puts "give a gif"
      new_input = gets.chomp
      puts "here is your request: #{new_input}"
      #run give_gif(url)
    elsif input[0] == "get"
      puts "get a gif"
      new_input = gets.chomp
      puts "here is your request: #{new_input}"
      #run get_gif
    else
      puts "There was an error in your request."
      puts "Try one of these requests:"
      puts "./giffer give url.gif (to insert a new gif)"
      puts "./giffer get (to receive an old gif)"
    end #of input check

  end #of initialize

end #of class

gif_app = App.new(ARGV)
