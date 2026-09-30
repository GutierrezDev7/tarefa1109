import 'package:flutter/material.dart';

import '../core/escopo.dart';
import '../core/escuta.dart';
import '../core/formatacao.dart';
import '../core/navegacao.dart';
import '../core/tema.dart';
import '../models/produto.dart';
import 'componentes/botao_carrinho.dart';
import 'componentes/painel_produto.dart';

class TelaProdutos extends StatefulWidget {
  const TelaProdutos({super.key});

  @override
  State<TelaProdutos> createState() => _TelaProdutosState();
}

class _TelaProdutosState extends State<TelaProdutos> {
  final _buscaController = TextEditingController();

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  void _sair() {
    AppEscopo.of(context).encerrarSessao();
    Navegacao.encerrarEIrParaLogin(context);
  }

  void _limparFiltros() {
    _buscaController.clear();
    AppEscopo.of(context).produtos.limparFiltros();
  }

  @override
  Widget build(BuildContext context) {
    final controladores = AppEscopo.of(context);

    return Escuta(
      observavel: controladores.produtos,
      builder: (context, produtos) {
        return Escuta(
          observavel: controladores.carrinho,
          builder: (context, carrinho) {
            final nome = controladores.autenticacao.primeiroNome;
            final lista = produtos.visiveis;

            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 68,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aurora',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Tema.acento,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(nome.isEmpty ? 'Catálogo' : 'Olá, $nome'),
                  ],
                ),
                actions: [
                  IconButton(
                    tooltip: 'Sair',
                    onPressed: _sair,
                    icon: const Icon(Icons.logout),
                  ),
                  BotaoCarrinho(quantidade: carrinho.quantidadeItens),
                ],
              ),
              body: CustomScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Catálogo',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Tema.tinta,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _rotuloResultados(lista.length),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _buscaController,
                            textInputAction: TextInputAction.search,
                            onChanged: produtos.definirBusca,
                            decoration: const InputDecoration(
                              hintText: 'Buscar por nome ou categoria',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 64,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                        itemCount: produtos.categorias.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final categoria = produtos.categorias[index];
                          return ChoiceChip(
                            label: Text(categoria),
                            selected: produtos.categoria == categoria,
                            showCheckmark: false,
                            onSelected: (_) => produtos.selecionarCategoria(categoria),
                          );
                        },
                      ),
                    ),
                  ),
                  if (lista.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _CatalogoVazio(onLimpar: _limparFiltros),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.62,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _CartaoProduto(produto: lista[index]),
                          childCount: lista.length,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String _rotuloResultados(int quantidade) {
    if (quantidade == 0) return 'Nenhum resultado';
    if (quantidade == 1) return '1 produto';
    return '$quantidade produtos';
  }
}

class _CatalogoVazio extends StatelessWidget {
  const _CatalogoVazio({required this.onLimpar});

  final VoidCallback onLimpar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 56, color: Colors.black.withValues(alpha: 0.28)),
          const SizedBox(height: 12),
          const Text(
            'Nenhum produto encontrado',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ajuste a busca ou limpe os filtros para ver o catálogo.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          OutlinedButton(onPressed: onLimpar, child: const Text('Limpar filtros')),
        ],
      ),
    );
  }
}

class _CartaoProduto extends StatelessWidget {
  const _CartaoProduto({required this.produto});

  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0x14000000)),
      ),
      child: InkWell(
        onTap: () => Navegacao.abrirDetalhe(context, produto.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: PainelProduto(produto: produto)),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produto.categoria.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w700,
                      color: Tema.destaque,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    produto.titulo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700, height: 1.2),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formatarMoeda(produto.preco),
                    style: const TextStyle(
                      color: Tema.preco,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
