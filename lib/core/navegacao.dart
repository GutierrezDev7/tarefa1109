import 'package:flutter/material.dart';

class Navegacao {
  static const login = '/login';
  static const cadastro = '/cadastro';
  static const produtos = '/produtos';
  static const detalhe = '/produto';
  static const carrinho = '/carrinho';

  static void abrirCadastro(BuildContext context) {
    Navigator.pushNamed(context, cadastro);
  }

  static void abrirDetalhe(BuildContext context, String produtoId) {
    Navigator.pushNamed(context, detalhe, arguments: produtoId);
  }

  static void abrirCarrinho(BuildContext context) {
    Navigator.pushNamed(context, carrinho);
  }

  static void entrarNaLoja(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, produtos, (route) => false);
  }

  static void encerrarEIrParaLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, login, (route) => false);
  }

  static void voltarAoLogin(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      return;
    }
    encerrarEIrParaLogin(context);
  }

  static void voltarAoCatalogo(BuildContext context) {
    Navigator.popUntil(
      context,
      (route) => route.settings.name == produtos || route.isFirst,
    );
  }
}
