class Produto {
  final int id;
  final String nome;
  final double preco;
  final int estoque;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.estoque,
  });

  Produto copyWith({int? id, String? nome, double? preco, int? estoque}) {
    return Produto(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      preco: preco ?? this.preco,
      estoque: estoque ?? this.estoque,
    );
  }

  @override
  String toString() =>
      'Produto(id: $id, nome: $nome, preço: R\$${preco.toStringAsFixed(2)}, estoque: $estoque)';
}
