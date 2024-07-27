import 'package:chat_explain_ia/consts/info_card_mensagem.dart';
import 'package:chat_explain_ia/data/mensagem_resposta_model.dart';
import 'package:flutter/material.dart';

class CardMensagemResposta extends StatelessWidget {
  const CardMensagemResposta({
    super.key,
    required this.model,
  });

  final MensagemRespostaModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Topico(InfoCardMensagem.resposta, model.resposta),
            const SizedBox(height: 7),
            _Topico(InfoCardMensagem.justificativa, model.justificativa),
            const SizedBox(height: 7),
            _TopicoLista(_getTituloReferencias(), model.referencias),
          ],
        ),
      ),
    );
  }

  String _getTituloReferencias() {
    return model.referencias.isNotEmpty ? InfoCardMensagem.referencias : InfoCardMensagem.semReferencias;
  }
}

class _Topico extends StatelessWidget {
  const _Topico(this.titulo, this.descricao);

  final String titulo, descricao;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$titulo $descricao",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _TopicoLista extends StatelessWidget {
  const _TopicoLista(this.titulo, this.listagem);

  final String titulo;
  final List<String> listagem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TituloLista(titulo),
        _ItensListagem(listagem),
      ],
    );
  }
}

class _TituloLista extends StatelessWidget {
  const _TituloLista(this.titulo);

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Text(
      titulo,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _ItensListagem extends StatelessWidget {
  const _ItensListagem(this.listagem);

  final List<String> listagem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listagem.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 5),
          child: ListTile(
            minTileHeight: 20,
            leading: const Icon(Icons.link, size: 20),
            title: Text(
              listagem[index],
              style: const TextStyle(fontSize: 12),
            ),
          ),
        );
      },
    );
  }
}
