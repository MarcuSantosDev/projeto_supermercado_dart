import '../repositories/produto_repository.dart';
import '../repositories/venda_repository.dart';
import '../repositories/cliente_repository.dart';
import '../models/item_venda.dart';
import '../models/produto.dart';
import '../models/venda.dart';

class VendaService {
  final VendaRepository _vendaRepository;
  final ProdutoRepository _produtoRepository;
  final ClienteRepository _clienteRepository;

  VendaService(
    this._vendaRepository,
    this._produtoRepository,
    this._clienteRepository,
  );

  String realizarVenda({
    required String clienteId,
    required Map<String, int> produtosComQuantidade,
    String? observacoes,
  }) {
    // Validar cliente
    final cliente = _clienteRepository.getById(clienteId);
    if (cliente == null) {
      throw Exception('Cliente não encontrado');
    }

    if (!cliente.ativo) {
      throw Exception('Cliente inativo. Não é possível realizar venda.');
    }

    if (produtosComQuantidade.isEmpty) {
      throw Exception('Venda deve ter pelo menos um produto');
    }

    // Processar itens e validar estoque
    final itens = <ItemVenda>[];
    final produtosAtualizados = <Produto>[];

    for (final entry in produtosComQuantidade.entries) {
      final produtoId = entry.key;
      final quantidade = entry.value;

      if (quantidade <= 0) {
        throw Exception('Quantidade deve ser maior que zero');
      }

      final produto = _produtoRepository.getById(produtoId);
      if (produto == null) {
        throw Exception('Produto $produtoId não encontrado');
      }

      if (!produto.ativo) {
        throw Exception('Produto ${produto.nome} está inativo');
      }

      if (produto.estoque < quantidade) {
        throw Exception(
          'Estoque insuficiente para ${produto.nome}. Disponível: ${produto.estoque}, Solicitado: $quantidade',
        );
      }

      // Criar item da venda
      itens.add(ItemVenda(produto: produto, quantidade: quantidade));

      // Preparar atualização de estoque
      produtosAtualizados.add(
        produto.copyWith(estoque: produto.estoque - quantidade),
      );
    }

    // Gerar ID da venda
    final vendaId = _gerarId();

    // Criar venda
    final venda = Venda(
      id: vendaId,
      cliente: cliente,
      itens: itens,
      observacoes: observacoes,
    );

    // Salvar venda
    _vendaRepository.add(venda);

    // Atualizar estoque dos produtos
    for (final produto in produtosAtualizados) {
      _produtoRepository.update(produto);
    }

    return vendaId;
  }

  void confirmarVenda(String vendaId) {
    final venda = _vendaRepository.getById(vendaId);
    if (venda == null) {
      throw Exception('Venda não encontrada');
    }

    if (venda.status != StatusVenda.pendente) {
      throw Exception('Apenas vendas pendentes podem ser confirmadas');
    }

    final vendaConfirmada = venda.copyWith(status: StatusVenda.confirmada);
    _vendaRepository.update(vendaConfirmada);
  }

  void cancelarVenda(String vendaId) {
    final venda = _vendaRepository.getById(vendaId);
    if (venda == null) {
      throw Exception('Venda não encontrada');
    }

    if (!venda.podeSerCancelada) {
      throw Exception('Esta venda não pode ser cancelada');
    }

    // Devolver produtos ao estoque
    for (final item in venda.itens) {
      final produto = _produtoRepository.getById(item.produto.id);
      if (produto != null) {
        final produtoAtualizado = produto.copyWith(
          estoque: produto.estoque + item.quantidade,
        );
        _produtoRepository.update(produtoAtualizado);
      }
    }

    final vendaCancelada = venda.copyWith(status: StatusVenda.cancelada);
    _vendaRepository.update(vendaCancelada);
  }

  List<Venda> listarTodas() => _vendaRepository.getAll();

  List<Venda> listarPorCliente(String clienteId) =>
      _vendaRepository.getByCliente(clienteId);

  List<Venda> listarPorStatus(StatusVenda status) =>
      _vendaRepository.getByStatus(status);

  List<Venda> listarPorPeriodo(DateTime inicio, DateTime fim) =>
      _vendaRepository.getByPeriodo(inicio, fim);

  Venda? buscarPorId(String id) => _vendaRepository.getById(id);

  double calcularTotalVendas() => _vendaRepository.getTotalVendas();

  String _gerarId() => DateTime.now().millisecondsSinceEpoch.toString();
}
