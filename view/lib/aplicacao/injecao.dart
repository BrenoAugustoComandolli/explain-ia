import 'package:chat_explain_ia/data/repository/api_repository.dart';
import 'package:chat_explain_ia/pages/chat/domain/cubit/chat_cubit.dart';
import 'package:chat_explain_ia/pages/chat/domain/service/chat_service.dart';
import 'package:chat_explain_ia/util/url_util.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final class Injecao {
  static final GetIt getIt = GetIt.instance;

  static void executar() {
    getIt.registerLazySingleton(() => Dio());
    getIt.registerLazySingleton(() => ApiRepository(getIt()));
    getIt.registerLazySingleton(() => ChatService(getIt()));
    getIt.registerLazySingleton(() => ChatCubit(getIt()));
    getIt.registerLazySingleton(() => UrlUtil());
  }
}
