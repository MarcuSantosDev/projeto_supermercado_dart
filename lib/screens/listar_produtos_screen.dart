import 'package:flutter/material.dart';
import '../globals.dart';
import '../models/produto.dart';

class ListarProdutosScreen extends StatelessWidget {
  const ListarProdutosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Buscar produtos sempre que a tela abrir
    final List<Produto> produtos = produtoService.listarTodos();

    return Scaffold(
      appBar: AppBar(title: const Text('Produtos')),
      body: produtos.isEmpty
          ? const Center(child: Text('Nenhum produto cadastrado.'))
          : ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                final produto = produtos[index];
                return ListTile(
                  title: Text(produto.nome),
                  subtitle: Text(
                    "Preço: R\$ ${produto.preco.toStringAsFixed(2)} | "
                    "Estoque: ${produto.estoque}",
                  ),
                );
              },
            ),
    );
  }
}
