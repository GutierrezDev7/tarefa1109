import 'package:flutter/material.dart';

import '../../core/navegacao.dart';

class BotaoCarrinho extends StatelessWidget {
  const BotaoCarrinho({super.key, required this.quantidade});

  final int quantidade;

  @override
  Widget build(BuildContext context) {
    final rotulo = quantidade > 99 ? '99+' : '$quantidade';

    return IconButton(
      tooltip: 'Abrir carrinho',
      onPressed: () => Navegacao.abrirCarrinho(context),
      icon: Badge(
        isLabelVisible: quantidade > 0,
        backgroundColor: const Color(0xFFD4B483),
        textColor: const Color(0xFF142824),
        label: Text(rotulo),
        child: const Icon(Icons.shopping_bag_outlined),
      ),
    );
  }
}
