import 'package:chat_explain_ia/consts/info_boas_vindas.dart';
import 'package:chat_explain_ia/data/mensagem_model.dart';
import 'package:chat_explain_ia/pages/base_page.dart';
import 'package:chat_explain_ia/pages/chat/widgets/card_mensagem.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BasePage(
      titulo: "Explain IA",
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            _ListagemMensagens(),
            _CampoPesquisa(),
          ],
        ),
      ),
    );
  }
}

class _ListagemMensagens extends StatelessWidget {
  const _ListagemMensagens();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          const _MensagemBoasVindas(),
          CardMensagem(
            model: MensagemModel("", "", "", ["Teste"]),
          ),
        ],
      ),
    );
  }
}

class _MensagemBoasVindas extends StatelessWidget {
  const _MensagemBoasVindas();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Icon(Icons.person),
          SizedBox(height: 10),
          Text(
            InfoBoasVindas.titulo,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            InfoBoasVindas.descricao,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _CampoPesquisa extends StatelessWidget {
  const _CampoPesquisa();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      child: TextField(),
    );
  }
}
