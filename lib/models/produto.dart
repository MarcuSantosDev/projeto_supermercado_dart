class Produto {
  final String id;
  final String nome;
  final String? descricao;
  final double preco;
  final int estoque;
  final bool ativo;
  final DateTime dataCadastro;

  Produto({
    required this.id,
    required this.nome,
    this.descricao,
    required this.preco,
    required this.estoque,
    this.ativo = true,
    DateTime? dataCadastro,
  }) : dataCadastro = dataCadastro ?? DateTime.now();

  bool get temEstoqueDisponivel => estoque > 0 && ativo;

  Produto copyWith({
    String? id,
    String? nome,
    String? descricao,
    double? preco,
    int? estoque,
    bool? ativo,
    DateTime? dataCadastro,
  }) {
    return Produto(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      preco: preco ?? this.preco,
      estoque: estoque ?? this.estoque,
      ativo: ativo ?? this.ativo,
      dataCadastro: dataCadastro ?? this.dataCadastro,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'descricao': descricao,
    'preco': preco,
    'estoque': estoque,
    'ativo': ativo,
    'dataCadastro': dataCadastro.toIso8601String(),
  };

  factory Produto.fromJson(Map<String, dynamic> json) => Produto(
    id: json['id'] as String,
    nome: json['nome'] as String,
    descricao: json['descricao'] as String?,
    preco: (json['preco'] as num).toDouble(),
    estoque: json['estoque'] as int,
    ativo: json['ativo'] as bool? ?? true,
    dataCadastro: DateTime.parse(json['dataCadastro'] as String),
  );

  @override
  String toString() =>
      'Produto(id: $id, nome: $nome, preço: R\$${preco.toStringAsFixed(2)}, estoque: $estoque)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Produto && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
