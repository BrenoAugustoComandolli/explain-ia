import 'package:chat_explain_ia/data/i_mensagem.dart';

class MensagemRespostaModel implements IMensagem {
  final String resposta;
  final String justificativa;
  final List<String> referencias;

  MensagemRespostaModel(
    this.resposta,
    this.justificativa,
    this.referencias,
  );

  MensagemRespostaModel.fromJson(Map<String, dynamic> json)
      : resposta = json['resposta'],
        justificativa = json['justificativa'],
        referencias = List<String>.from(json['referencias']);
}
