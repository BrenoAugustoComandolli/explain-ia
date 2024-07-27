import 'package:chat_explain_ia/consts/info_erros.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlUtil {
  Future<void> redirecionar(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('${InfoErros.erroRedirecionamento} $url');
    }
  }
}
