# encoding: UTF-8

class Game
  def initialize(output = STDOUT)
    @output = output
  end
  
  def start
    initial_message = "Você quer advinhar uma palavra " <<
                      "com quantas letras?"
    @output.puts initial_message
  end
end
