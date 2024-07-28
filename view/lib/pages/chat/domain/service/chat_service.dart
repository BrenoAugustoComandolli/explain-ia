import 'package:chat_explain_ia/consts/info_erros.dart';
import 'package:chat_explain_ia/data/mensagem_pergunta_model.dart';
import 'package:chat_explain_ia/data/mensagem_resposta_model.dart';
import 'package:chat_explain_ia/data/repository/api_repository.dart';
import 'package:result_dart/result_dart.dart';

class ChatService {
  const ChatService(this.repository);

  final ApiRepository repository;
  final String _rota = '/explain/pergunta';

  AsyncResult<MensagemRespostaModel, MensagemRespostaModel> realizaPergunta(String pergunta) async {
    try {
      final resultado = await repository.post(_rota, data: MensagemPerguntaModel(pergunta).toJson());
      if (resultado.statusCode == 200) {
        return Success(MensagemRespostaModel.fromJson(resultado.data));
      }
      return Failure(MensagemRespostaModel(
        InfoErros.erroRealizarPergunta,
        resultado.data.toString(),
        [],
      ));
    } catch (e) {
      return Failure(MensagemRespostaModel(
        InfoErros.erroRealizarPergunta,
        e.toString(),
        [],
      ));
    }
  }
}
