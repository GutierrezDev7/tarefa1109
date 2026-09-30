import 'package:flutter/material.dart';

import 'core/controladores.dart';
import 'core/escopo.dart';
import 'core/navegacao.dart';
import 'core/rotas.dart';
import 'core/tema.dart';

void main() {
  runApp(MeuApp(controladores: Controladores()));
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key, required this.controladores});

  final Controladores controladores;

  @override
  Widget build(BuildContext context) {
    return AppEscopo(
      controladores: controladores,
      child: MaterialApp(
        title: 'Aurora',
        debugShowCheckedModeBanner: false,
        theme: Tema.claro(),
        initialRoute: Navegacao.login,
        onGenerateRoute: (settings) => Rotas.gerar(settings, controladores),
      ),
    );
  }
}
