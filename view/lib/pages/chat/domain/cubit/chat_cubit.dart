import 'package:chat_explain_ia/data/i_mensagem.dart';
import 'package:chat_explain_ia/data/mensagem_pergunta_model.dart';
import 'package:chat_explain_ia/pages/chat/domain/cubit/chat_state.dart';
import 'package:chat_explain_ia/pages/chat/domain/service/chat_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._service) : super(ChatInicialState());

  final ChatService _service;

  final List<IMensagem> _lMensagens = [];

  List<IMensagem> get mensagens => _lMensagens;

  void reset() {
    _lMensagens.clear();
    emit(ChatInicialState());
  }

  Future<void> realizaPergunta(String pergunta) async {
    _lMensagens.add(MensagemPerguntaModel(pergunta, ""));
    emit(ChatPesquisandoState());

    final resultado = await _service.realizaPergunta(pergunta);

    resultado.fold(
      (success) => _lMensagens.add(success),
      (error) => _lMensagens.add(error),
    );
    emit(ChatPesquisaRealizadaState());
  }
}
