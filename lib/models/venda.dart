import 'cliente.dart';
import 'item_venda.dart';

enum StatusVenda {
  pendente,
  confirmada,
  cancelada;

  String get descricao {
    switch (this) {
      case StatusVenda.pendente:
        return 'Pendente';
      case StatusVenda.confirmada:
        return 'Confirmada';
      case StatusVenda.cancelada:
        return 'Cancelada';
    }
  }
}

class Venda {
  final String id;
  final Cliente cliente;
  final List<ItemVenda> itens;
  final DateTime data;
  final StatusVenda status;
  final String? observacoes;

  Venda({
    required this.id,
    required this.cliente,
    required this.itens,
    DateTime? data,
    this.status = StatusVenda.confirmada,
    this.observacoes,
  }) : data = data ?? DateTime.now();

  double get total => itens.fold(0.0, (sum, item) => sum + item.subtotal);

  int get totalItens => itens.fold(0, (sum, item) => sum + item.quantidade);

  bool get podeSerCancelada =>
      status == StatusVenda.pendente || status == StatusVenda.confirmada;

  Venda copyWith({
    String? id,
    Cliente? cliente,
    List<ItemVenda>? itens,
    DateTime? data,
    StatusVenda? status,
    String? observacoes,
  }) {
    return Venda(
      id: id ?? this.id,
      cliente: cliente ?? this.cliente,
      itens: itens ?? this.itens,
      data: data ?? this.data,
      status: status ?? this.status,
      observacoes: observacoes ?? this.observacoes,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'cliente': cliente.toJson(),
    'itens': itens.map((i) => i.toJson()).toList(),
    'data': data.toIso8601String(),
    'status': status.name,
    'total': total,
    'observacoes': observacoes,
  };

  factory Venda.fromJson(Map<String, dynamic> json) => Venda(
    id: json['id'] as String,
    cliente: Cliente.fromJson(json['cliente'] as Map<String, dynamic>),
    itens: (json['itens'] as List)
        .map((i) => ItemVenda.fromJson(i as Map<String, dynamic>))
        .toList(),
    data: DateTime.parse(json['data'] as String),
    status: StatusVenda.values.byName(json['status'] as String),
    observacoes: json['observacoes'] as String?,
  );

  @override
  String toString() {
    final itensStr = itens.map((i) => '  - $i').join('\n');
    return '''
Venda #$id
Cliente: ${cliente.nome}
Status: ${status.descricao}
Itens ($totalItens):
$itensStr
Total: R\$${total.toStringAsFixed(2)}
Data: ${data.toLocal()}
${observacoes != null ? 'Obs: $observacoes' : ''}
''';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Venda && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
