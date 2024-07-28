import 'package:chat_explain_ia/consts/chaves_local_storage_consts.dart';
import 'package:chat_explain_ia/consts/info_login_dialog_consts.dart';
import 'package:chat_explain_ia/util/local_storage_util.dart';
import 'package:flutter/material.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _recuperaLoginLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(InfoLoginDialogConsts.loginTitulo),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: InfoLoginDialogConsts.loginHint,
        ),
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(InfoLoginDialogConsts.loginCancelar),
        ),
        ElevatedButton(
          onPressed: _salvaLogin,
          child: const Text(InfoLoginDialogConsts.loginSalvar),
        ),
      ],
    );
  }

  void _salvaLogin() {
    String login = _controller.text;
    if (login.trim().isNotEmpty) {
      LocalStorageUtil.salvaString(ChavesLocalStorageConsts.chaveLogin, login);
      Navigator.of(context).pop();
    }
  }

  Future<void> _recuperaLoginLocalStorage() async {
    String? login = await LocalStorageUtil.recuperaString(ChavesLocalStorageConsts.chaveLogin);
    _controller.text = login ?? '';
  }
}
