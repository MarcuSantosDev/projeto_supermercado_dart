import '../models/produto.dart';

class ProdutoRepository {
  final Map<String, Produto> _produtos = {};

  List<Produto> getAll() => List.unmodifiable(_produtos.values.toList());

  Produto? getById(String id) => _produtos[id];

  void add(Produto produto) {
    if (_produtos.containsKey(produto.id)) {
      throw Exception('Produto com ID ${produto.id} já existe');
    }
    _produtos[produto.id] = produto;
  }

  void update(Produto produto) {
    if (!_produtos.containsKey(produto.id)) {
      throw Exception('Produto com ID ${produto.id} não encontrado');
    }
    _produtos[produto.id] = produto;
  }

  void delete(String id) {
    if (!_produtos.containsKey(id)) {
      throw Exception('Produto com ID $id não encontrado');
    }
    _produtos.remove(id);
  }

  List<Produto> getAtivos() => _produtos.values.where((p) => p.ativo).toList();

  List<Produto> getComEstoque() =>
      _produtos.values.where((p) => p.temEstoqueDisponivel).toList();

  List<Produto> buscarPorNome(String nome) => _produtos.values
      .where((p) => p.nome.toLowerCase().contains(nome.toLowerCase()))
      .toList();
}
