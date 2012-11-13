# encoding: UTF-8

Quando /^inicio o jogo$/ do
  game = Game.new
  game.start
end

Então /^vejo na tela:$/ do |string|
  pending
end