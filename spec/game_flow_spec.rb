# encoding: UTF-8

require 'spec_helper'
require 'game_flow'

describe GameFlow do
  let(:ui) { double("ui").as_null_object }
  let(:game) { double("game",
                      state: :initial,
                      guessed_letters: []).as_null_object }

  subject(:game_flow) { GameFlow.new(game, ui) }

  describe "#start" do
    it "prints the initial message" do
      initial_message = "Bem-vindo ao jogo da forca!"
      ui.should_receive(:write).with(initial_message)

      game_flow.start
    end
  end

  describe "#next_step" do
    context "when the game is in the 'initial' state" do
      it "asks the player for the length of the word to be raffled" do
        question = "Qual o tamanho da palavra a ser sorteada?"
        ui.should_receive(:write).with(question)

        word_length = "3"
        ui.should_receive(:read).and_return(word_length)

        game_flow.next_step
      end

      context "and the player asks to raffle a word" do
        it "raffles a word with the given length" do
          word_length = "3"
          ui.stub(read: word_length)

          game.should_receive(:raffle).with(word_length.to_i)

          game_flow.next_step
        end

        it "prints a '_' for each letter in the raffled word" do
          word_length = "3"
          ui.stub(read: word_length)
          game.stub(raffle: "mom", raffled_word: "mom")

          ui.should_receive(:write).with("_ _ _")

          game_flow.next_step
        end

        it "tells if it's not possible to raffle with the given length" do
          word_length = "20"
          ui.stub(read: word_length)
          game.stub(raffle: nil)

          error_message = "Não temos uma palavra com o tamanho " <<
                         "desejado,\n" <<
                         "é necessário escolher outro tamanho."

          ui.should_receive(:write).with(error_message)

          game_flow.next_step
        end
      end
    end

    context "when the game is in the 'word raffled' state" do
      before { game.stub(state: :word_raffled) }

      it "asks the player to guess a letter" do
        question = "Qual letra você acha que a palavra tem?"
        ui.should_receive(:write).with(question)

        game_flow.next_step
      end

      context "and the player guess a letter with success" do
        before { game.stub(guess_letter: true) }

        it "prints a success message" do
          success_message = "Você adivinhou uma letra com sucesso."
          ui.should_receive(:write).with(success_message)

          game_flow.next_step
        end

        it "prints the guessed letters" do
          game.stub(raffled_word: "hey", guessed_letters: ["e"])

          ui.should_receive(:write).with("_ e _")

          game_flow.next_step
        end
      end

      context "and the player fails to guess a letter" do
        before { game.stub(guess_letter: false) }

        it "prints a error message" do
          error_message = "Você errou a letra."
          ui.should_receive(:write).with(error_message)

          game_flow.next_step
        end

        it "prints the list of the missed parts" do
          game.stub(missed_parts: ["cabeça"])

          missed_parts_message = "O boneco da forca perdeu as " <<
                                 "seguintes partes do corpo: cabeça"
          ui.should_receive(:write).with(missed_parts_message)

          game_flow.next_step
        end
      end
    end

    context "when the game is in the 'ended' state" do
      before { game.stub(state: :ended) }

      it "prints a success message whe the player win" do
        game.stub(player_won?: true)

        ui.should_receive(:write).with("Você venceu! :)")

        game_flow.next_step
      end

      it "prints a defeat message when the player lose" do
        game.stub(player_won?: false)

        ui.should_receive(:write).with("Você perdeu. :(")

        game_flow.next_step
      end
    end

    it "finishes the game when the player asks to" do
      player_input = "fim"
      ui.stub(read: player_input)

      game.stub(state: :initial)
      game.should_receive(:finish)
      game_flow.next_step

      game.stub(state: :word_raffled)
      game.should_receive(:finish)
      game_flow.next_step
    end
  end
end
