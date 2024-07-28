import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    super.key,
    required this.titulo,
    required this.body,
    this.actions,
  });

  final String titulo;
  final Widget body;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(titulo),
          actions: actions,
        ),
        body: body,
      ),
    );
  }
}
