# encoding: UTF-8

require_relative 'cli_ui'

class Game
  attr_reader :raffled_word

  def initialize(ui = CliUi.new)
    @ui = ui
    @ended = false
  end

  def start
    initial_message = "Bem vindo ao jogo da forca!"
    @ui.write(initial_message)
  end

  def ended?
    @ended
  end

  def next_step
    @ui.write("Qual o tamanho da palavra a ser sorteada?")
    user_input = @ui.read.strip

    if user_input == "fim"
      @ended = true
    else
      if raffle_word(user_input.to_i)
        print_letters_feedback
      else
        error_message = "Não temos uma palavra com o tamanho " <<
                        "desejado,\n" <<
                        "é necessário escolher outro tamanho."

        @ui.write(error_message)
      end
    end
  end

  private
  def raffle_word(word_length)
    words = %w(hi mom game fruit)
    @raffled_word = words.detect { |word| word.length == word_length }
  end

  def print_letters_feedback
    letters_feedback = ""

    @raffled_word.length.times do
      letters_feedback << "_ "
    end

    letters_feedback.strip!

    @ui.write(letters_feedback)
  end
end