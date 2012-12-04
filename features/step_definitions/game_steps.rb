# encoding: UTF-8

Dado /^que comecei um jogo$/ do
  start_new_game
end

Quando /^começo um novo jogo$/ do
  start_new_game
end

Quando /^termino o jogo$/ do
  steps %{
    When I type "fim"
  }
end

Quando /^escolho que a palavra a ser sorteada deverá ter "(.*?)" letras\
$/ do |number_of_letters|
  steps %{
    When I type "#{number_of_letters}"
  }
end

Então /^o jogo termina com a seguinte mensagem na tela:$/ do |text|
  steps %{
    Then it should pass with:
      """
      #{text}
      """
  }
end
