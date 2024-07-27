

class MensagemRespostaModel {
  final String pergunta;
  final String resposta;
  final String justificativa;
  final List<String> referencias;

  MensagemRespostaModel(
    this.pergunta,
    this.resposta,
    this.justificativa,
    this.referencias,
  );
}
