import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meuprojetoflutter/core/controladores.dart';
import 'package:meuprojetoflutter/main.dart';

void main() {
  testWidgets('login valida os campos e abre o cadastro', (tester) async {
    await tester.pumpWidget(MeuApp(controladores: Controladores()));

    expect(find.text('Entrar na loja'), findsOneWidget);
    expect(find.text('Criar cadastro'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Entrar'));
    await tester.pump();

    expect(find.text('Informe o e-mail'), findsOneWidget);
    expect(find.text('Informe a senha'), findsOneWidget);

    await tester.tap(find.text('Criar cadastro'));
    await tester.pumpAndSettle();

    expect(find.text('Criar conta'), findsOneWidget);
    expect(find.text('Cadastrar'), findsOneWidget);
  });

  testWidgets('conta de demonstração abre o catálogo', (tester) async {
    await tester.pumpWidget(MeuApp(controladores: Controladores()));

    await tester.tap(find.text('Usar conta de demonstração'));
    await tester.pumpAndSettle();

    expect(find.text('Olá, Ana'), findsOneWidget);
    expect(find.text('Fone Aura Pro'), findsOneWidget);
    expect(find.text('Catálogo'), findsOneWidget);
  });
}
