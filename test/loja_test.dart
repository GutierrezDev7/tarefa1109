import 'package:flutter_test/flutter_test.dart';
import 'package:meuprojetoflutter/controllers/autenticacao_controller.dart';
import 'package:meuprojetoflutter/controllers/carrinho_controller.dart';
import 'package:meuprojetoflutter/controllers/produto_controller.dart';
import 'package:meuprojetoflutter/core/formatacao.dart';
import 'package:meuprojetoflutter/models/catalogo.dart';

void main() {
  test('formata valores em real', () {
    expect(formatarMoeda(1890), 'R\$ 1.890,00');
    expect(formatarMoeda(349.90), 'R\$ 349,90');
    expect(formatarMoeda(0), 'R\$ 0,00');
  });

  test('entra com a conta de demonstração', () {
    final auth = AutenticacaoController();

    expect(
      auth.entrar(
        AutenticacaoController.emailDemonstracao,
        AutenticacaoController.senhaDemonstracao,
      ),
      isNull,
    );
    expect(auth.autenticado, isTrue);
    expect(auth.primeiroNome, 'Ana');
  });

  test('recusa cadastro com e-mail já usado', () {
    final auth = AutenticacaoController();

    final erro = auth.cadastrar(
      nome: 'Ana Ribeiro',
      email: AutenticacaoController.emailDemonstracao,
      senha: '123456',
    );

    expect(erro, 'Já existe uma conta com este e-mail.');
  });

  test('filtra o catálogo por busca e categoria', () {
    final produtos = ProdutoController();

    produtos.definirBusca('fone');
    expect(produtos.visiveis.map((produto) => produto.id), ['fone-aura']);

    produtos.limparFiltros();
    produtos.selecionarCategoria('Calçados');
    expect(produtos.visiveis, hasLength(1));
    expect(produtos.visiveis.single.categoria, 'Calçados');
  });

  test('soma quantidades e respeita o limite do carrinho', () {
    final carrinho = CarrinhoController();
    final produto = Catalogo.itens.first;

    expect(carrinho.adicionar(produto, quantidade: 2), isNull);
    expect(carrinho.adicionar(produto), isNull);
    expect(carrinho.quantidadeItens, 3);
    expect(carrinho.valorTotal, produto.preco * 3);

    expect(carrinho.adicionar(produto, quantidade: 8), isNotNull);
    expect(carrinho.quantidadeItens, 3);

    final codigo = carrinho.finalizar();
    expect(codigo, startsWith('AUR-'));
    expect(carrinho.itens, isEmpty);
  });
}
