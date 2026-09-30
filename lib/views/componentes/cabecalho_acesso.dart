import 'package:flutter/material.dart';

import '../../core/tema.dart';

class CabecalhoAcesso extends StatelessWidget {
  const CabecalhoAcesso({
    super.key,
    required this.titulo,
    required this.subtitulo,
  });

  final String titulo;
  final String subtitulo;

  @override
  Widget build(BuildContext context) {
    final topo = MediaQuery.paddingOf(context).top;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, topo + 12, 24, 32),
      decoration: const BoxDecoration(
        color: Tema.tinta,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Navigator.canPop(context))
            IconButton(
              tooltip: 'Voltar',
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            )
          else
            const SizedBox(height: 12),
          const SizedBox(height: 12),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.wb_twilight, color: Tema.acento, size: 30),
          ),
          const SizedBox(height: 20),
          Text(
            'Aurora',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Tema.acento,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            titulo,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitulo,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.78),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
