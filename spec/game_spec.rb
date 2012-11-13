# encoding: UTF-8

require 'spec_helper'
require 'game'

describe Game do
  describe "#start" do
    it "prints the initial message" do
      output = double("output")
      game = Game.new(output)

      initial_message = "Você quer advinhar uma palavra " << 
                        "com quantas letras?"
      output.should_receive(:puts).with(initial_message)

      game.start
    end
  end
end