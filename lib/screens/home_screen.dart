import 'package:flutter/material.dart';
import '../globals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final produtos = produtoService.listarTodos();
    final clientes = clienteService.listarTodos();
    final vendas = vendaService.listarTodas();
    
    final totalProdutos = produtos.length;
    final totalClientes = clientes.length;
    final totalVendas = vendas.length;
    final totalVendasValor = vendas.fold(0.0, (sum, v) => sum + v.total);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema Supermercado'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header com estatísticas
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.shopping_cart,
                    size: 64,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Bem-vindo!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Gerencie seu supermercado de forma fácil',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            // Cards de estatísticas
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.inventory_2,
                      title: 'Produtos',
                      value: totalProdutos.toString(),
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.people,
                      title: 'Clientes',
                      value: totalClientes.toString(),
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.receipt_long,
                      title: 'Vendas',
                      value: totalVendas.toString(),
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.attach_money,
                      title: 'Faturamento',
                      value: 'R\$ ${totalVendasValor.toStringAsFixed(2)}',
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Seção de Produtos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Produtos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _MenuCard(
                    icon: Icons.list_alt,
                    title: 'Listar Produtos',
                    subtitle: 'Visualize todos os produtos cadastrados',
                    color: Colors.blue,
                    onTap: () => Navigator.pushNamed(context, '/produtos/listar').then((_) => setState(() {})),
                  ),
                  const SizedBox(height: 8),
                  _MenuCard(
                    icon: Icons.add_circle,
                    title: 'Cadastrar Produto',
                    subtitle: 'Adicione um novo produto ao estoque',
                    color: Colors.blue,
                    onTap: () => Navigator.pushNamed(context, '/produtos/cadastrar').then((_) => setState(() {})),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Seção de Clientes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Clientes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _MenuCard(
                    icon: Icons.people_outline,
                    title: 'Listar Clientes',
                    subtitle: 'Visualize todos os clientes cadastrados',
                    color: Colors.purple,
                    onTap: () => Navigator.pushNamed(context, '/clientes/listar').then((_) => setState(() {})),
                  ),
                  const SizedBox(height: 8),
                  _MenuCard(
                    icon: Icons.person_add,
                    title: 'Cadastrar Cliente',
                    subtitle: 'Cadastre um novo cliente',
                    color: Colors.purple,
                    onTap: () => Navigator.pushNamed(context, '/clientes/cadastrar').then((_) => setState(() {})),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Seção de Vendas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Vendas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _MenuCard(
                    icon: Icons.receipt,
                    title: 'Listar Vendas',
                    subtitle: 'Visualize todas as vendas realizadas',
                    color: Colors.orange,
                    onTap: () => Navigator.pushNamed(context, '/vendas/listar').then((_) => setState(() {})),
                  ),
                  const SizedBox(height: 8),
                  _MenuCard(
                    icon: Icons.add_shopping_cart,
                    title: 'Registrar Venda',
                    subtitle: 'Registre uma nova venda',
                    color: Colors.green,
                    onTap: () => Navigator.pushNamed(context, '/vendas/registrar').then((_) => setState(() {})),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
