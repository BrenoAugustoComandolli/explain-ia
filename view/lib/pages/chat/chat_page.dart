import 'package:chat_explain_ia/consts/info_boas_vindas.dart';
import 'package:chat_explain_ia/consts/info_card_mensagem.dart';
import 'package:chat_explain_ia/data/i_mensagem.dart';
import 'package:chat_explain_ia/pages/base_page.dart';
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
            _BarraPesquisa(),
          ],
        ),
      ),
    );
  }
}

class _ListagemMensagens extends StatelessWidget {
  const _ListagemMensagens(this.lMensagens);

  final List<IMensagem> lMensagens;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          const _MensagemBoasVindas(),
          ...lMensagens,
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

class _BarraPesquisa extends StatelessWidget {
  const _BarraPesquisa();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              _CampoDigitacao(),
              SizedBox(width: 10),
              _BotaoNovaMensagem(),
            ],
          ),
        ],
      ),
    );
  }
}

class _CampoDigitacao extends StatelessWidget {
  const _CampoDigitacao();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          hintText: InfoCardMensagem.digiteMensagem,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}

class _BotaoNovaMensagem extends StatelessWidget {
  const _BotaoNovaMensagem();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.add),
    );
  }
}
