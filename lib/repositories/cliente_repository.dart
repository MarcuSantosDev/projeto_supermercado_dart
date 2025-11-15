import '../models/cliente.dart';

class ClienteRepository {
  final Map<String, Cliente> _clientes = {};

  List<Cliente> getAll() => List.unmodifiable(_clientes.values.toList());

  Cliente? getById(String id) => _clientes[id];

  void add(Cliente cliente) {
    if (_clientes.containsKey(cliente.id)) {
      throw Exception('Cliente com ID ${cliente.id} já existe');
    }
    _clientes[cliente.id] = cliente;
  }

  void update(Cliente cliente) {
    if (!_clientes.containsKey(cliente.id)) {
      throw Exception('Cliente com ID ${cliente.id} não encontrado');
    }
    _clientes[cliente.id] = cliente;
  }

  void delete(String id) {
    if (!_clientes.containsKey(id)) {
      throw Exception('Cliente com ID $id não encontrado');
    }
    _clientes.remove(id);
  }

  Cliente? getByEmail(String email) {
    try {
      return _clientes.values.firstWhere(
        (c) => c.email.toLowerCase() == email.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  List<Cliente> getAtivos() => _clientes.values.where((c) => c.ativo).toList();
}
