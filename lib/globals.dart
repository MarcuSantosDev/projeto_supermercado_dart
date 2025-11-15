import 'repositories/produto_repository.dart';
import 'repositories/cliente_repository.dart';
import 'repositories/venda_repository.dart';

import 'services/produto_service.dart';
import 'services/cliente_service.dart';
import 'services/venda_service.dart';

// Repositórios globais
final produtoRepository = ProdutoRepository();
final clienteRepository = ClienteRepository();
final vendaRepository = VendaRepository();

// Services globais
final produtoService = ProdutoService(produtoRepository);
final clienteService = ClienteService(clienteRepository);
final vendaService = VendaService(
  vendaRepository,
  produtoRepository,
  clienteRepository,
);

