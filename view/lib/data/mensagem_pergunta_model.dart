import 'package:chat_explain_ia/data/i_mensagem.dart';

class MensagemPerguntaModel implements IMensagem {
  final String pergunta;
  final String login;

  MensagemPerguntaModel(
    this.pergunta,
    this.login,
  );

  Map<String, dynamic> toJson() => {
        'pergunta': pergunta,
        'login': login,
      };
}
