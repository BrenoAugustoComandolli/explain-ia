import 'package:chat_explain_ia/data/mensagem_pergunta_model.dart';
import 'package:chat_explain_ia/identidade_visual/cores_sistema.dart';
import 'package:flutter/material.dart';

class CardMensagemPergunta extends StatelessWidget {
  const CardMensagemPergunta({
    super.key,
    required this.model,
  });

  final MensagemPerguntaModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Card(
          color: CoresSistema.primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  model.pergunta,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
