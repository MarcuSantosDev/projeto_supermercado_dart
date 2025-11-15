import '../models/venda.dart';

class VendaRepository {
  final Map<String, Venda> _vendas = {};

  List<Venda> getAll() => List.unmodifiable(_vendas.values.toList());

  Venda? getById(String id) => _vendas[id];

  void add(Venda venda) {
    if (_vendas.containsKey(venda.id)) {
      throw Exception('Venda com ID ${venda.id} já existe');
    }
    _vendas[venda.id] = venda;
  }

  void update(Venda venda) {
    if (!_vendas.containsKey(venda.id)) {
      throw Exception('Venda com ID ${venda.id} não encontrada');
    }
    _vendas[venda.id] = venda;
  }

  void delete(String id) {
    if (!_vendas.containsKey(id)) {
      throw Exception('Venda com ID $id não encontrada');
    }
    _vendas.remove(id);
  }

  List<Venda> getByCliente(String clienteId) =>
      _vendas.values.where((v) => v.cliente.id == clienteId).toList();

  List<Venda> getByStatus(StatusVenda status) =>
      _vendas.values.where((v) => v.status == status).toList();

  List<Venda> getByPeriodo(DateTime inicio, DateTime fim) => _vendas.values
      .where((v) => v.data.isAfter(inicio) && v.data.isBefore(fim))
      .toList();

  double getTotalVendas() =>
      _vendas.values.fold(0.0, (sum, venda) => sum + venda.total);
}
