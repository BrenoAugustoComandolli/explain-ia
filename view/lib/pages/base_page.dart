import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    super.key,
    required this.titulo,
    required this.body,
  });

  final String titulo;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(titulo),
        ),
        body: body,
      ),
    );
  }
}
