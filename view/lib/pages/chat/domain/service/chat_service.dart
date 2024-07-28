import 'package:chat_explain_ia/consts/chaves_local_storage_consts.dart';
import 'package:chat_explain_ia/consts/info_erros_consts.dart';
import 'package:chat_explain_ia/data/mensagem_pergunta_model.dart';
import 'package:chat_explain_ia/data/mensagem_resposta_model.dart';
import 'package:chat_explain_ia/data/repository/api_repository.dart';
import 'package:chat_explain_ia/util/local_storage_util.dart';
import 'package:result_dart/result_dart.dart';

class ChatService {
  const ChatService(this.repository);

  final ApiRepository repository;
  final String _rota = '/explain/pergunta';

  AsyncResult<MensagemRespostaModel, MensagemRespostaModel> realizaPergunta(String pergunta) async {
    try {
      final resultado = await repository.post(_rota,
          data: MensagemPerguntaModel(
            pergunta,
            await _recuperaLogin(),
          ).toJson());
      if (resultado.statusCode == 200) {
        return Success(MensagemRespostaModel.fromJson(resultado.data));
      }
      return Failure(MensagemRespostaModel(
        InfoErrosConsts.erroRealizarPergunta,
        resultado.data.toString(),
        [],
      ));
    } catch (e) {
      return Failure(MensagemRespostaModel(
        InfoErrosConsts.erroRealizarPergunta,
        e.toString(),
        [],
      ));
    }
  }

  Future<String> _recuperaLogin() async {
    final String? login = await LocalStorageUtil.recuperaString(
      ChavesLocalStorageConsts.chaveLogin,
    );
 
    if (login == null) {
      throw Exception(InfoErrosConsts.erroLoginNaoEncontrado);
    }
    return login;
  }
}
