import 'package:flutter/material.dart';

import '../controllers/autenticacao_controller.dart';
import '../views/tela_cadastro.dart';
import '../views/tela_carrinho.dart';
import '../views/tela_detalhe_produto.dart';
import '../views/tela_login.dart';
import '../views/tela_produtos.dart';
import 'controladores.dart';
import 'navegacao.dart';

class Rotas {
  static Route<void> gerar(RouteSettings settings, Controladores controladores) {
    switch (settings.name) {
      case Navegacao.login:
        return _pagina(const TelaLogin(), settings);
      case Navegacao.cadastro:
        return _pagina(const TelaCadastro(), settings);
      case Navegacao.produtos:
        return _pagina(_proteger(controladores.autenticacao, const TelaProdutos()), settings);
      case Navegacao.detalhe:
        final argumento = settings.arguments;
        final id = argumento is String ? argumento : '';
        return _pagina(
          _proteger(controladores.autenticacao, TelaDetalheProduto(produtoId: id)),
          settings,
        );
      case Navegacao.carrinho:
        return _pagina(_proteger(controladores.autenticacao, const TelaCarrinho()), settings);
      default:
        return _pagina(const TelaLogin(), settings);
    }
  }

  static Widget _proteger(AutenticacaoController autenticacao, Widget tela) {
    if (!autenticacao.autenticado) return const TelaLogin();
    return tela;
  }

  static MaterialPageRoute<void> _pagina(Widget tela, RouteSettings settings) {
    return MaterialPageRoute(settings: settings, builder: (_) => tela);
  }
}
