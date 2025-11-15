import 'cliente.dart';
import 'produto.dart';

class ItemVenda {
  final Produto produto;
  final int quantidade;
  final double subtotal;

  ItemVenda({required this.produto, required this.quantidade})
    : subtotal = produto.preco * quantidade;

  @override
  String toString() =>
      '${produto.nome} (x$quantidade) - R\$${subtotal.toStringAsFixed(2)}';
}

class Venda {
  final int id;
  final Cliente cliente;
  final List<ItemVenda> itens;
  final DateTime data;
  final double total;

  Venda({
    required this.id,
    required this.cliente,
    required this.itens,
    required this.data,
  }) : total = itens.fold(0, (sum, item) => sum + item.subtotal);

  @override
  String toString() {
    final itensStr = itens.map((i) => i.toString()).join('\n  ');
    return '''
Venda #$id
Cliente: ${cliente.nome}
Itens:
  $itensStr
Total: R\$${total.toStringAsFixed(2)}
Data: ${data.toLocal()}
''';
  }
}
