import '../repositories/cliente_repository.dart';
import '../models/cliente.dart';

class ClienteService {
  final ClienteRepository _repository;

  ClienteService(this._repository);

  String cadastrar({required String nome, required String email}) {
    // Validações
    if (nome.trim().isEmpty || nome.length < 3) {
      throw Exception('Nome deve ter no mínimo 3 caracteres');
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      throw Exception('Email inválido');
    }

    // Verifica se email já existe
    final clienteExistente = _repository.getByEmail(email);
    if (clienteExistente != null) {
      throw Exception('Email já cadastrado');
    }

    // Gera ID único
    final id = _gerarId();

    final cliente = Cliente(
      id: id,
      nome: nome.trim(),
      email: email.trim().toLowerCase(),
    );

    _repository.add(cliente);
    return id;
  }

  void atualizar({
    required String id,
    String? nome,
    String? email,
    bool? ativo,
  }) {
    final cliente = _repository.getById(id);
    if (cliente == null) {
      throw Exception('Cliente não encontrado');
    }

    // Validações se houver novos valores
    if (nome != null && (nome.trim().isEmpty || nome.length < 3)) {
      throw Exception('Nome deve ter no mínimo 3 caracteres');
    }

    if (email != null) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        throw Exception('Email inválido');
      }

      // Verifica se o novo email já está em uso por outro cliente
      final clienteComEmail = _repository.getByEmail(email);
      if (clienteComEmail != null && clienteComEmail.id != id) {
        throw Exception('Email já cadastrado para outro cliente');
      }
    }

    final clienteAtualizado = cliente.copyWith(
      nome: nome,
      email: email,
      ativo: ativo,
    );

    _repository.update(clienteAtualizado);
  }

  void desativar(String id) {
    final cliente = _repository.getById(id);
    if (cliente == null) {
      throw Exception('Cliente não encontrado');
    }

    final clienteDesativado = cliente.copyWith(ativo: false);
    _repository.update(clienteDesativado);
  }

  void ativar(String id) {
    final cliente = _repository.getById(id);
    if (cliente == null) {
      throw Exception('Cliente não encontrado');
    }

    final clienteAtivado = cliente.copyWith(ativo: true);
    _repository.update(clienteAtivado);
  }

  void remover(String id) {
    _repository.delete(id);
  }

  List<Cliente> listarTodos() => _repository.getAll();

  List<Cliente> listarAtivos() => _repository.getAtivos();

  Cliente? buscarPorId(String id) => _repository.getById(id);

  Cliente? buscarPorEmail(String email) => _repository.getByEmail(email);

  String _gerarId() => DateTime.now().millisecondsSinceEpoch.toString();
}
