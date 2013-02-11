# encoding: UTF-8

require 'spec_helper'
require 'game'

describe Game do
  let(:word_raffler) { double("raffler").as_null_object }

  subject(:game) { Game.new(word_raffler) }

  context "when just created" do
    its(:state) { should == :initial }
  end

  describe "#ended?" do
    it "returns false when the game just started" do
      game.should_not be_ended
    end
  end

  describe "#raffle" do
    it "raffles a word with the given length" do
      word_raffler.should_receive(:raffle).with(3)

      game.raffle(3)
    end

    it "saves the raffled word" do
      raffled_word = "mom"
      word_raffler.stub(raffle: raffled_word)

      game.raffle(3)

      game.raffled_word.should == raffled_word
    end

    it "makes a transition from :initial to :word_raffled on success" do
      word_raffler.stub(raffle: "word")

      expect do
        game.raffle(3)
      end.to change { game.state }.from(:initial).to(:word_raffled)
    end

    it "stays on the :initial state when a word can't be raffled" do
      word_raffler.stub(raffle: nil)

      game.raffle(3)

      game.state.should == :initial
    end
  end

  describe "#guess_letter" do
    it "returns true if the raffled word contains the given letter" do
      game.raffled_word = "hey"

      game.guess_letter("h").should be_true
    end

    it "saves the guessed letter when the guess is right" do
      game.raffled_word = "hey"

      expect do
        game.guess_letter("h")
      end.to change { game.guessed_letters }.from([]).to(["h"])
    end

    it "does not save a guessed letter more than once" do
      game.raffled_word = "hey"
      game.guess_letter("h")

      expect do
        game.guess_letter("h")
      end.to_not change { game.guessed_letters }.from(["h"])
    end

    it "returns false if the raffled word doesn't contain the given" <<
       " letter" do
      game.raffled_word = "hey"

      game.guess_letter("z").should be_false
    end

    it "returns false if the given letter is an blank string" do
      game.raffled_word = "hey"

      game.guess_letter("").should be_false
      game.guess_letter("   ").should be_false
    end

    it "updates the missed parts when the guess is wrong" do
      game.raffled_word = "hey"

      game.guess_letter("z")

      game.missed_parts.should == ["cabeça"]
    end

    it "makes a transition to the 'ended' state when all the letters " <<
       "are guessed with success" do
       game.state = :word_raffled
       game.raffled_word = "hi"

       game.guess_letter("h")
       game.guess_letter("i")

       game.state.should == :ended
    end
  end

  describe "#guessed_letters" do
    it "returns the guessed letters" do
      game.raffled_word = "hey"
      game.guess_letter("e")

      game.guessed_letters.should == ["e"]
    end

    it "returns an empty array when there's no guessed letters" do
      game.guessed_letters.should == []
    end
  end

  describe "#missed_parts" do
    it "returns an empty array when there's no missed parts" do
      game.missed_parts.should == []
    end

    it "returns the missed parts for each fail in guessing a letter" do
      game.raffled_word = "hey"

      3.times do
        game.guess_letter("z")
      end

      game.missed_parts.should == ["cabeça", "corpo", "braço esquerdo"]
    end
  end

  describe "#finish" do
    it "sets the game as ended" do
      game.finish

      game.should be_ended
    end
  end

  describe "#user_won?" do
    it "returns true when the user guessed all letters with success" do
      game.state = :word_raffled
      game.raffled_word = "hi"

      game.guess_letter("h")
      game.guess_letter("i")

      game.user_won?.should be_true
    end

    it "returns false when the user didn't guessed all letters" do
      game.state = :word_raffled
      game.raffled_word = "hi"

      6.times { game.guess_letter("z") }

      game.user_won?.should be_false
    end

    it "returns false when the game is not in the 'ended' state" do
      game.state = :initial
      game.user_won?.should be_false

      game.state = :word_raffled
      game.user_won?.should be_false
    end
  end

end
