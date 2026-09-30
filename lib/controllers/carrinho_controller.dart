import 'package:flutter/foundation.dart';

import '../models/item_carrinho.dart';
import '../models/produto.dart';

class CarrinhoController extends ChangeNotifier {
  static const quantidadeMaxima = 10;

  final List<ItemCarrinho> _itens = [];

  List<ItemCarrinho> get itens => List.unmodifiable(_itens);

  int get quantidadeItens {
    var total = 0;
    for (final item in _itens) {
      total += item.quantidade;
    }
    return total;
  }

  double get valorTotal {
    var total = 0.0;
    for (final item in _itens) {
      total += item.subtotal;
    }
    return total;
  }

  String? adicionar(Produto produto, {int quantidade = 1}) {
    if (quantidade <= 0) return 'Quantidade inválida.';

    final indice = _itens.indexWhere((item) => item.produto.id == produto.id);
    final atual = indice < 0 ? 0 : _itens[indice].quantidade;
    if (atual + quantidade > quantidadeMaxima) {
      return 'O limite deste item é $quantidadeMaxima unidades.';
    }

    if (indice < 0) {
      _itens.add(ItemCarrinho(produto: produto, quantidade: quantidade));
    } else {
      _itens[indice].quantidade = atual + quantidade;
    }

    notifyListeners();
    return null;
  }

  void alterarQuantidade(String produtoId, int delta) {
    final indice = _itens.indexWhere((item) => item.produto.id == produtoId);
    if (indice < 0 || delta == 0) return;

    final nova = _itens[indice].quantidade + delta;
    if (nova > quantidadeMaxima) return;

    if (nova <= 0) {
      _itens.removeAt(indice);
    } else {
      _itens[indice].quantidade = nova;
    }
    notifyListeners();
  }

  void remover(String produtoId) {
    final tamanho = _itens.length;
    _itens.removeWhere((item) => item.produto.id == produtoId);
    if (_itens.length != tamanho) notifyListeners();
  }

  void limpar() {
    if (_itens.isEmpty) return;
    _itens.clear();
    notifyListeners();
  }

  String? finalizar() {
    if (_itens.isEmpty) return null;
    final base = DateTime.now().millisecondsSinceEpoch.toRadixString(16).toUpperCase();
    final sufixo = base.length <= 6 ? base : base.substring(base.length - 6);
    _itens.clear();
    notifyListeners();
    return 'AUR-$sufixo';
  }
}
