class Produto {
  const Produto({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.categoria,
    required this.preco,
    required this.imagemUrl,
    required this.cor,
  });

  final String id;
  final String titulo;
  final String descricao;
  final String categoria;
  final double preco;
  final String imagemUrl;
  final int cor;
}
