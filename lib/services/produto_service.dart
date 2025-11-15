import '../repositories/produto_repository.dart';
import '../models/produto.dart';

class ProdutoService {
  final ProdutoRepository _repository;

  ProdutoService(this._repository);

  String cadastrar({
    required String nome,
    required double preco,
    required int estoque,
    String? descricao,
  }) {
    // Validações
    if (nome.trim().isEmpty) {
      throw Exception('Nome do produto não pode ser vazio');
    }

    if (preco < 0) {
      throw Exception('Preço não pode ser negativo');
    }

    if (estoque < 0) {
      throw Exception('Estoque não pode ser negativo');
    }

    // Gera ID único
    final id = _gerarId();

    final produto = Produto(
      id: id,
      nome: nome.trim(),
      descricao: descricao?.trim(),
      preco: preco,
      estoque: estoque,
    );

    _repository.add(produto);
    return id;
  }

  void atualizar({
    required String id,
    String? nome,
    String? descricao,
    double? preco,
    int? estoque,
    bool? ativo,
  }) {
    final produto = _repository.getById(id);
    if (produto == null) {
      throw Exception('Produto não encontrado');
    }

    // Validações
    if (nome != null && nome.trim().isEmpty) {
      throw Exception('Nome do produto não pode ser vazio');
    }

    if (preco != null && preco < 0) {
      throw Exception('Preço não pode ser negativo');
    }

    if (estoque != null && estoque < 0) {
      throw Exception('Estoque não pode ser negativo');
    }

    final produtoAtualizado = produto.copyWith(
      nome: nome,
      descricao: descricao,
      preco: preco,
      estoque: estoque,
      ativo: ativo,
    );

    _repository.update(produtoAtualizado);
  }

  void ajustarEstoque(String id, int quantidade) {
    final produto = _repository.getById(id);
    if (produto == null) {
      throw Exception('Produto não encontrado');
    }

    final novoEstoque = produto.estoque + quantidade;

    if (novoEstoque < 0) {
      throw Exception(
        'Estoque insuficiente. Estoque atual: ${produto.estoque}, tentativa de redução: ${quantidade.abs()}',
      );
    }

    final produtoAtualizado = produto.copyWith(estoque: novoEstoque);
    _repository.update(produtoAtualizado);
  }

  void adicionarEstoque(String id, int quantidade) {
    if (quantidade <= 0) {
      throw Exception('Quantidade deve ser maior que zero');
    }
    ajustarEstoque(id, quantidade);
  }

  void removerEstoque(String id, int quantidade) {
    if (quantidade <= 0) {
      throw Exception('Quantidade deve ser maior que zero');
    }
    ajustarEstoque(id, -quantidade);
  }

  void desativar(String id) {
    final produto = _repository.getById(id);
    if (produto == null) {
      throw Exception('Produto não encontrado');
    }

    final produtoDesativado = produto.copyWith(ativo: false);
    _repository.update(produtoDesativado);
  }

  void ativar(String id) {
    final produto = _repository.getById(id);
    if (produto == null) {
      throw Exception('Produto não encontrado');
    }

    final produtoAtivado = produto.copyWith(ativo: true);
    _repository.update(produtoAtivado);
  }

  void remover(String id) {
    _repository.delete(id);
  }

  List<Produto> listarTodos() => _repository.getAll();

  List<Produto> listarAtivos() => _repository.getAtivos();

  List<Produto> listarComEstoque() => _repository.getComEstoque();

  List<Produto> buscarPorNome(String nome) => _repository.buscarPorNome(nome);

  Produto? buscarPorId(String id) => _repository.getById(id);

  String _gerarId() => DateTime.now().millisecondsSinceEpoch.toString();
}
