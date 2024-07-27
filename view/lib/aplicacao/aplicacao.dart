import 'package:chat_explain_ia/aplicacao/injecao.dart';

final class Aplicacao {
  static void prepararAmbiente() {
    Injecao.executar();
  }
}
