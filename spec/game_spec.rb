# encoding: UTF-8

require 'spec_helper'
require 'game'

describe Game do
  let(:ui) { double("ui").as_null_object }

  subject(:game) { Game.new(ui) }

  describe "#start" do
    it "prints the initial message" do
      initial_message = "Bem vindo ao jogo da forca!"
      ui.should_receive(:write).with(initial_message)

      game.start
    end
  end

  describe "#ended?" do
    it "returns false when the game just started" do
      game.should_not be_ended
    end
  end

  describe "#next step" do
    context "when the game just started" do
      it "asks the user for the length of the word to be raffled" do
        question = "Qual o tamanho da palavra a ser sorteada?"
        ui.should_receive(:write).with(question)

        word_length = "3"
        ui.should_receive(:read).and_return(word_length)

        game.next_step
      end
    end

    context "when the user asks to raffle a word" do
      it "raffles a word with the given length" do
        word_length = "3"
        ui.stub(read: word_length)

        game.next_step

        game.raffled_word.should have(word_length).letters
      end

      it "prints a '_' for each letter in the raffled word" do
        word_length = "3"
        ui.stub(read: word_length)

        ui.should_receive(:write).with("_ _ _")

        game.next_step
      end
    end


    it "finishes the game when the user asks to" do
      user_input = "fim"
      ui.stub(read: user_input)

      game.next_step

      game.should be_ended
    end
  end
end
