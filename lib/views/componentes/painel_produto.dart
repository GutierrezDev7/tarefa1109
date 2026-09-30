import 'package:flutter/material.dart';

import '../../models/produto.dart';

class PainelProduto extends StatelessWidget {
  const PainelProduto({super.key, required this.produto});

  final Produto produto;

  @override
  Widget build(BuildContext context) {
    final cor = Color(produto.cor);

    return Semantics(
      label: produto.titulo,
      image: true,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  cor,
                  cor.withValues(alpha: 0.72),
                ],
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final tamanho = constraints.maxWidth * 0.34;
                return Center(
                  child: Icon(
                    iconeDaCategoria(produto.categoria),
                    color: Colors.white.withValues(alpha: 0.92),
                    size: tamanho.clamp(22, 78),
                  ),
                );
              },
            ),
          ),
          Image.network(
            produto.imagemUrl,
            fit: BoxFit.cover,
            excludeFromSemantics: true,
            errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

IconData iconeDaCategoria(String categoria) {
  switch (categoria) {
    case 'Áudio':
      return Icons.headphones;
    case 'Relógios':
      return Icons.watch_outlined;
    case 'Foto':
      return Icons.photo_camera_outlined;
    case 'Calçados':
      return Icons.directions_walk;
    case 'Informática':
      return Icons.keyboard_outlined;
    default:
      return Icons.shopping_bag_outlined;
  }
}
