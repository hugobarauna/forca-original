# language: pt

Funcionalidade: Começar jogo
  Para poder passar o tempo
  Como jogador
  Quero poder começar um novo jogo

  Cenário: Começo de novo jogo com sucesso
    Ao começar o jogo, é mostrada a mensagem inicial para o jogador.

    Quando inicio o jogo
    Então vejo na tela:
      """
      Você quer advinhar uma palavra com quantas letras?
      """
