import 'package:chat_explain_ia/aplicacao/injecao.dart';
import 'package:chat_explain_ia/consts/info_boas_vindas_consts.dart';
import 'package:chat_explain_ia/consts/info_card_mensagem_consts.dart';
import 'package:chat_explain_ia/data/mensagem_pergunta_model.dart';
import 'package:chat_explain_ia/data/mensagem_resposta_model.dart';
import 'package:chat_explain_ia/pages/base_page.dart';
import 'package:chat_explain_ia/pages/chat/domain/cubit/chat_cubit.dart';
import 'package:chat_explain_ia/pages/chat/domain/cubit/chat_state.dart';
import 'package:chat_explain_ia/pages/chat/widgets/card_mensagem_carregamento.dart';
import 'package:chat_explain_ia/pages/chat/widgets/card_mensagem_pergunta.dart';
import 'package:chat_explain_ia/pages/chat/widgets/card_mensagem_resposta.dart';
import 'package:chat_explain_ia/pages/chat/widgets/login_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatCubit _cubit = Injecao.getIt.get<ChatCubit>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      titulo: "Explain IA",
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const _MensagemBoasVindas(),
            _ListagemMensagens(_cubit),
            _BarraPesquisa(
              cubit: _cubit,
              controller: _controller,
            ),
          ],
        ),
      ),
      actions: const [
        _BotaoLogin(),
      ],
    );
  }
}

class _BotaoLogin extends StatelessWidget {
  const _BotaoLogin();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const LoginDialog();
          },
        );
      },
      icon: const Icon(Icons.person),
      color: Colors.black,
      style: ButtonStyle(
        side: WidgetStateProperty.all(BorderSide.none),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
    );
  }
}

class _ListagemMensagens extends StatelessWidget {
  const _ListagemMensagens(this.cubit);

  final ChatCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      bloc: cubit,
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            itemCount: _getQtdMensagens(state, cubit.mensagens),
            itemBuilder: (context, index) {
              if (_isRenderizaCardCarregamento(state, index, cubit.mensagens)) {
                return const CardMensagemCarregamento();
              }
              if (cubit.mensagens[index] is MensagemPerguntaModel) {
                return CardMensagemPergunta(
                  model: cubit.mensagens[index] as MensagemPerguntaModel,
                );
              }
              if (cubit.mensagens[index] is MensagemRespostaModel) {
                return CardMensagemResposta(
                  model: cubit.mensagens[index] as MensagemRespostaModel,
                );
              }
              return const Center();
            },
          ),
        );
      },
    );
  }

  int _getQtdMensagens(state, mensagens) {
    return state is ChatPesquisandoState ? mensagens.length + 1 : mensagens.length;
  }

  bool _isRenderizaCardCarregamento(state, index, mensagens) {
    return state is ChatPesquisandoState && index == mensagens.length;
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
            InfoBoasVindasConsts.titulo,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            InfoBoasVindasConsts.descricao,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _BarraPesquisa extends StatelessWidget {
  const _BarraPesquisa({required this.cubit, required this.controller});

  final ChatCubit cubit;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              _CampoDigitacao(
                controller: controller,
                onSubmitted: _enviaMensagem,
              ),
              const SizedBox(width: 10),
              _EnviarMensagem(
                controller: controller,
                onEnviaMensagem: _enviaMensagem,
              ),
              const SizedBox(width: 10),
              _BotaoNovaMensagem(cubit),
            ],
          ),
        ],
      ),
    );
  }

  void _enviaMensagem() {
    String pergunta = controller.value.text;
    if (pergunta.trim().isNotEmpty) {
      controller.clear();
      cubit.realizaPergunta(pergunta);
    }
  }
}

class _CampoDigitacao extends StatelessWidget {
  const _CampoDigitacao({
    required this.controller,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: InfoCardMensagemConsts.digiteMensagem,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
        ),
        onSubmitted: (value) => onSubmitted(),
      ),
    );
  }
}

class _EnviarMensagem extends StatelessWidget {
  const _EnviarMensagem({
    required this.controller,
    required this.onEnviaMensagem,
  });

  final TextEditingController controller;
  final VoidCallback onEnviaMensagem;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onEnviaMensagem,
      icon: const Icon(Icons.send),
    );
  }
}

class _BotaoNovaMensagem extends StatelessWidget {
  const _BotaoNovaMensagem(this.cubit);

  final ChatCubit cubit;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: cubit.reset,
      icon: const Icon(Icons.add),
    );
  }
}
