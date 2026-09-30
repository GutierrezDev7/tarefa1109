import 'package:flutter/material.dart';

import '../controllers/carrinho_controller.dart';
import '../core/escopo.dart';
import '../core/escuta.dart';
import '../core/formatacao.dart';
import '../core/navegacao.dart';
import '../core/tema.dart';
import '../models/item_carrinho.dart';
import 'componentes/painel_produto.dart';

class TelaCarrinho extends StatelessWidget {
  const TelaCarrinho({super.key});

  @override
  Widget build(BuildContext context) {
    final carrinho = AppEscopo.of(context).carrinho;

    return Escuta(
      observavel: carrinho,
      builder: (context, carrinho) {
        final vazio = carrinho.itens.isEmpty;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Carrinho'),
            actions: [
              if (!vazio)
                TextButton(
                  onPressed: carrinho.limpar,
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  child: const Text('Limpar'),
                ),
            ],
          ),
          body: vazio
              ? const _CarrinhoVazio()
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        itemCount: carrinho.itens.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = carrinho.itens[index];
                          return _ItemCarrinho(item: item, carrinho: carrinho);
                        },
                      ),
                    ),
                    _ResumoPedido(carrinho: carrinho),
                  ],
                ),
        );
      },
    );
  }
}

class _CarrinhoVazio extends StatelessWidget {
  const _CarrinhoVazio();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 72, color: Colors.black.withValues(alpha: 0.25)),
            const SizedBox(height: 16),
            const Text(
              'Seu carrinho está vazio',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'Escolha um produto no catálogo para começar o pedido.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => Navegacao.voltarAoCatalogo(context),
              child: const Text('Ver catálogo'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemCarrinho extends StatelessWidget {
  const _ItemCarrinho({required this.item, required this.carrinho});

  final ItemCarrinho item;
  final CarrinhoController carrinho;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0x14000000)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navegacao.abrirDetalhe(context, item.produto.id),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 76,
                  height: 76,
                  child: PainelProduto(produto: item.produto),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.produto.titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatarMoeda(item.subtotal),
                      style: const TextStyle(color: Tema.preco, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _BotaoQuantidade(
                          icone: Icons.remove,
                          tooltip: 'Diminuir',
                          onPressed: () => carrinho.alterarQuantidade(item.produto.id, -1),
                        ),
                        SizedBox(
                          width: 28,
                          child: Text(
                            '${item.quantidade}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        _BotaoQuantidade(
                          icone: Icons.add,
                          tooltip: 'Aumentar',
                          onPressed: () {
                            if (item.quantidade >= CarrinhoController.quantidadeMaxima) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'O limite deste item é ${CarrinhoController.quantidadeMaxima} unidades.',
                                  ),
                                ),
                              );
                              return;
                            }
                            carrinho.alterarQuantidade(item.produto.id, 1);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Remover',
                onPressed: () => carrinho.remover(item.produto.id),
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BotaoQuantidade extends StatelessWidget {
  const _BotaoQuantidade({
    required this.icone,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icone;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      visualDensity: VisualDensity.compact,
      icon: Icon(icone, size: 18),
    );
  }
}

class _ResumoPedido extends StatelessWidget {
  const _ResumoPedido({required this.carrinho});

  final CarrinhoController carrinho;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0x14000000))),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  carrinho.quantidadeItens == 1 ? '1 item' : '${carrinho.quantidadeItens} itens',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                Text(
                  formatarMoeda(carrinho.valorTotal),
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Tema.tinta),
                ),
              ],
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: () => _confirmarPedido(context, carrinho),
              child: const Text('Finalizar pedido'),
            ),
            TextButton(
              onPressed: () => Navegacao.voltarAoCatalogo(context),
              child: const Text('Continuar comprando'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _confirmarPedido(BuildContext context, CarrinhoController carrinho) async {
  final total = carrinho.valorTotal;
  final codigo = carrinho.finalizar();
  if (codigo == null || !context.mounted) return;

  await showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Pedido confirmado'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Número $codigo'),
            const SizedBox(height: 8),
            Text(
              'Total ${formatarMoeda(total)}',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continuar'),
          ),
        ],
      );
    },
  );
}
