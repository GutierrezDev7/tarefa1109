import 'package:flutter/foundation.dart';
import '../models/item_carrinho.dart';
import '../models/produtos.dart';

class ServicoCarrinho extends ChangeNotifier {
  static final ServicoCarrinho _instance = ServicoCarrinho._internal();

  factory ServicoCarrinho() {
    return _instance;
  }

  ServicoCarrinho._internal();

  final List<ItemCarrinho> _itens = [];

  List<ItemCarrinho> get itens => _itens;

  void adicionarProduto(Produto produto) {
    for (var item in _itens) {
      if (item.produto.id == produto.id) {
        item.quantidade++;
        notifyListeners();
        return;
      }
    }
    _itens.add(ItemCarrinho(produto: produto));
    notifyListeners();
  }

  void removerProduto(Produto produto) {
    _itens.removeWhere((item) => item.produto.id == produto.id);
    notifyListeners();
  }

  void limparCarrinho() {
    _itens.clear();
    notifyListeners();
  }

  double get valorTotal {
    double total = 0.0;
    for (var item in _itens) {
      total += item.produto.preco * item.quantidade;
    }
    return total;
  }

  int get quantidadeItens {
    int count = 0;
    for (var item in _itens) {
      count += item.quantidade;
    }
    return count;
  }
}
