import 'package:chat_explain_ia/data/i_mensagem.dart';

class MensagemPerguntaModel implements IMensagem {
  final String pergunta;

  MensagemPerguntaModel(
    this.pergunta,
  );

  Map<String, dynamic> toJson() => {
        'pergunta': pergunta,
      };
}
