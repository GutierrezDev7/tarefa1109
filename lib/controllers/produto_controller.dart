import 'package:flutter/foundation.dart';

import '../models/catalogo.dart';
import '../models/produto.dart';

class ProdutoController extends ChangeNotifier {
  final List<Produto> _catalogo = Catalogo.itens;

  String _busca = '';
  String _categoria = 'Todos';

  String get busca => _busca;

  String get categoria => _categoria;

  List<String> get categorias {
    final nomes = <String>{for (final produto in _catalogo) produto.categoria};
    return ['Todos', ...nomes];
  }

  List<Produto> get visiveis {
    final termo = _busca.trim().toLowerCase();
    return _catalogo.where((produto) {
      final categoriaOk = _categoria == 'Todos' || produto.categoria == _categoria;
      final buscaOk = termo.isEmpty ||
          produto.titulo.toLowerCase().contains(termo) ||
          produto.descricao.toLowerCase().contains(termo) ||
          produto.categoria.toLowerCase().contains(termo);
      return categoriaOk && buscaOk;
    }).toList();
  }

  Produto? buscarPorId(String id) {
    for (final produto in _catalogo) {
      if (produto.id == id) return produto;
    }
    return null;
  }

  void definirBusca(String termo) {
    if (_busca == termo) return;
    _busca = termo;
    notifyListeners();
  }

  void selecionarCategoria(String categoria) {
    if (_categoria == categoria) return;
    _categoria = categoria;
    notifyListeners();
  }

  void limparFiltros() {
    if (_busca.isEmpty && _categoria == 'Todos') return;
    _busca = '';
    _categoria = 'Todos';
    notifyListeners();
  }
}
