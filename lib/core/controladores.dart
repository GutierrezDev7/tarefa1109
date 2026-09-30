import '../controllers/autenticacao_controller.dart';
import '../controllers/carrinho_controller.dart';
import '../controllers/produto_controller.dart';

class Controladores {
  Controladores({
    AutenticacaoController? autenticacao,
    ProdutoController? produtos,
    CarrinhoController? carrinho,
  }) : autenticacao = autenticacao ?? AutenticacaoController(),
       produtos = produtos ?? ProdutoController(),
       carrinho = carrinho ?? CarrinhoController();

  final AutenticacaoController autenticacao;
  final ProdutoController produtos;
  final CarrinhoController carrinho;

  void encerrarSessao() {
    autenticacao.sair();
    carrinho.limpar();
    produtos.limparFiltros();
  }
}
