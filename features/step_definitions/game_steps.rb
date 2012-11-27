# encoding: UTF-8

Quando /^começo um novo jogo$/ do
  steps %{
    When I run `forca` interactively
  }
end

Então /^vejo na tela:$/ do |text|
  steps %{
    Then the stdout should contain "#{text}"
  }
end