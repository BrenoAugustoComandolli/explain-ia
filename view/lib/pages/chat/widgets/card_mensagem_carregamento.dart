import 'package:flutter/material.dart';

class CardMensagemCarregamento extends StatefulWidget {
  const CardMensagemCarregamento({super.key});

  @override
  State<CardMensagemCarregamento> createState() => _CardMensagemCarregamentoState();
}

class _CardMensagemCarregamentoState extends State<CardMensagemCarregamento> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..repeat();
    _animation = IntTween(begin: 0, end: 3).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                String dots = '.' * (_animation.value + 1);
                return Text("Processando resposta $dots");
              },
            ),
          ],
        ),
      ),
    );
  }
}
