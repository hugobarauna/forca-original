# encoding: UTF-8

Dado /^o jogo tem as possíveis palavras para sortear:$/ do |words_table|
  words = words_table.rows.map(&:last).join(" ")
  set_rafflable_words(words)
end

Dado /^que comecei um jogo$/ do
  start_new_game
end

Dado /^que escolhi que a palavra a ser sorteada deverá ter "(.*?)"\
 letras\
$/ do |number_of_letters|
  steps %{
    When I type "#{number_of_letters}"
  }
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

Quando /^tento adivinhar que a palavra tem a letra "(.*?)"$/ do |letter|
  steps %{
    When I type "#{letter}"
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

Então /^o jogo mostra que eu adivinhei uma letra com sucesso$/ do
  steps %{
    Then the stdout should contain:
      """
      Você adivinhou uma letra com sucesso.
      """
  }
end
