import 'produto.dart';

class ItemVenda {
  final Produto produto;
  final int quantidade;
  final double precoUnitario;
  final double desconto;

  ItemVenda({
    required this.produto,
    required this.quantidade,
    double? precoUnitario,
    this.desconto = 0.0,
  }) : precoUnitario = precoUnitario ?? produto.preco;

  double get subtotal => (precoUnitario * quantidade) * (1 - desconto / 100);

  Map<String, dynamic> toJson() => {
    'produto': produto.toJson(),
    'quantidade': quantidade,
    'precoUnitario': precoUnitario,
    'desconto': desconto,
    'subtotal': subtotal,
  };

  factory ItemVenda.fromJson(Map<String, dynamic> json) => ItemVenda(
    produto: Produto.fromJson(json['produto'] as Map<String, dynamic>),
    quantidade: json['quantidade'] as int,
    precoUnitario: (json['precoUnitario'] as num).toDouble(),
    desconto: (json['desconto'] as num?)?.toDouble() ?? 0.0,
  );

  @override
  String toString() =>
      '${produto.nome} (x$quantidade) - R\$${precoUnitario.toStringAsFixed(2)} = R\$${subtotal.toStringAsFixed(2)}';
}
