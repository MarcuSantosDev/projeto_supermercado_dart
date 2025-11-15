import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Supermercado')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/produtos/listar'),
              child: const Text('Listar Produtos'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/produtos/cadastrar'),
              child: const Text('Cadastrar Produto'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/clientes/listar'),
              child: const Text('Listar Clientes'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/clientes/cadastrar'),
              child: const Text('Cadastrar Cliente'),
            ),
            const SizedBox(height: 20),

            // Vendas
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/vendas/listar'),
              child: const Text('Listar Vendas'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/vendas/registrar'),
              child: const Text('Registrar Venda'),
            ),
          ],
        ),
      ),
    );
  }
}
