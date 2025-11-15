import 'package:flutter/material.dart';
import '../globals.dart';
import '../models/venda.dart';

class ListarVendasScreen extends StatelessWidget {
  const ListarVendasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vendas = vendaService.listarTodas();

    return Scaffold(
      appBar: AppBar(title: const Text('Vendas')),
      body: vendas.isEmpty
          ? const Center(child: Text('Nenhuma venda registrada'))
          : ListView.builder(
              itemCount: vendas.length,
              itemBuilder: (context, index) {
                final venda = vendas[index];

                return ListTile(
                  title: Text('Venda #${venda.id}'),
                  subtitle: Text(
                    'Cliente: ${venda.cliente.nome}\n'
                    'Total: R\$ ${venda.total.toStringAsFixed(2)}',
                  ),
                  trailing: Text(
                    venda.status.name.toUpperCase(),
                    style: TextStyle(
                      color: venda.status == StatusVenda.confirmada
                          ? Colors.green
                          : venda.status == StatusVenda.cancelada
                              ? Colors.red
                              : Colors.orange,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
