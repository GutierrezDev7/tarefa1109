import 'package:flutter/widgets.dart';

import 'controladores.dart';

class AppEscopo extends InheritedWidget {
  const AppEscopo({
    super.key,
    required this.controladores,
    required super.child,
  });

  final Controladores controladores;

  static Controladores of(BuildContext context) {
    final escopo = context.dependOnInheritedWidgetOfExactType<AppEscopo>();
    assert(escopo != null, 'AppEscopo não encontrado no contexto.');
    return escopo!.controladores;
  }

  @override
  bool updateShouldNotify(AppEscopo oldWidget) => false;
}
