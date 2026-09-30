import 'package:flutter/material.dart';

import '../core/escopo.dart';
import '../core/escuta.dart';
import '../core/formatacao.dart';
import '../core/navegacao.dart';
import '../core/tema.dart';
import '../models/produto.dart';
import 'componentes/botao_carrinho.dart';
import 'componentes/painel_produto.dart';

class TelaDetalheProduto extends StatefulWidget {
  const TelaDetalheProduto({super.key, required this.produtoId});

  final String produtoId;

  @override
  State<TelaDetalheProduto> createState() => _TelaDetalheProdutoState();
}

class _TelaDetalheProdutoState extends State<TelaDetalheProduto> {
  var _quantidade = 1;

  void _alterarQuantidade(int delta) {
    final nova = _quantidade + delta;
    if (nova < 1 || nova > 10) return;
    setState(() => _quantidade = nova);
  }

  void _adicionar(Produto produto) {
    final carrinho = AppEscopo.of(context).carrinho;
    final erro = carrinho.adicionar(produto, quantidade: _quantidade);
    final tema = Theme.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(erro ?? '${produto.titulo} adicionado ao carrinho.'),
        backgroundColor: erro == null ? null : tema.colorScheme.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controladores = AppEscopo.of(context);
    final produto = controladores.produtos.buscarPorId(widget.produtoId);

    if (produto == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Produto')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Este produto não está no catálogo.'),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => Navegacao.voltarAoCatalogo(context),
                  child: const Text('Voltar ao catálogo'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Escuta(
      observavel: controladores.carrinho,
      builder: (context, carrinho) {
        final total = produto.preco * _quantidade;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 320,
                backgroundColor: Tema.tinta,
                foregroundColor: Colors.white,
                actions: [
                  BotaoCarrinho(quantidade: carrinho.quantidadeItens),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      PainelProduto(produto: produto),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.center,
                            colors: [Color(0x99000000), Color(0x00000000)],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        produto.categoria.toUpperCase(),
                        style: const TextStyle(
                          color: Tema.destaque,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        produto.titulo,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Tema.tinta,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formatarMoeda(produto.preco),
                        style: const TextStyle(
                          color: Tema.preco,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        produto.descricao,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.45),
                      ),
                      const SizedBox(height: 28),
                      TextButton.icon(
                        onPressed: () => Navegacao.abrirCarrinho(context),
                        icon: const Icon(Icons.shopping_bag_outlined),
                        label: Text(
                          carrinho.quantidadeItens == 0
                              ? 'Ver carrinho'
                              : 'Ver carrinho (${carrinho.quantidadeItens})',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Material(
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                child: Row(
                  children: [
                    _PassoQuantidade(
                      quantidade: _quantidade,
                      onDiminuir: () => _alterarQuantidade(-1),
                      onAumentar: () => _alterarQuantidade(1),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () => _adicionar(produto),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text('Adicionar · ${formatarMoeda(total)}'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PassoQuantidade extends StatelessWidget {
  const _PassoQuantidade({
    required this.quantidade,
    required this.onDiminuir,
    required this.onAumentar,
  });

  final int quantidade;
  final VoidCallback onDiminuir;
  final VoidCallback onAumentar;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0x14000000)),
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Diminuir',
            onPressed: quantidade > 1 ? onDiminuir : null,
            icon: const Icon(Icons.remove),
          ),
          SizedBox(
            width: 24,
            child: Text(
              '$quantidade',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          IconButton(
            tooltip: 'Aumentar',
            onPressed: quantidade < 10 ? onAumentar : null,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
