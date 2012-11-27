# language: pt

Funcionalidade: Começar jogo
  Para poder passar o tempo
  Como jogador
  Quero poder começar um novo jogo

  Cenário: Começo de novo jogo com sucesso
    Ao começar o jogo, é mostrada a mensagem inicial para o jogador.

    Quando começo um novo jogo
    E termino o jogo
    Então o jogo termina com a seguinte mensagem na tela:
      """
      Bem vindo ao jogo da forca!
      """