import 'package:shared_preferences/shared_preferences.dart';

final class LocalStorageUtil {
  static Future<bool> salvaString(String chave, String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(chave, valor);
  }

  static Future<String?> recuperaString(String chave) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(chave);
  }
}
