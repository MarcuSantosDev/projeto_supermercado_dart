import 'package:flutter/material.dart';
import '../globals.dart';

class RegistrarVendaScreen extends StatefulWidget {
  const RegistrarVendaScreen({super.key});

  @override
  State<RegistrarVendaScreen> createState() => _RegistrarVendaScreenState();
}

class _RegistrarVendaScreenState extends State<RegistrarVendaScreen> {
  String? clienteSelecionado;
  final Map<String, int> produtosSelecionados = {};
  final Map<String, TextEditingController> _controllers = {};

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 Agora filtra apenas clientes ATIVOS
    final clientes = clienteService
        .listarTodos()
        .where((c) => c.ativo)
        .toList();

    final produtos = produtoService.listarTodos();

    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Venda')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cliente:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              DropdownButtonFormField<String>(
                initialValue: clienteSelecionado,
                decoration: const InputDecoration(
                  labelText: "Cliente",
                  border: OutlineInputBorder(),
                ),
                hint: const Text('Selecione um cliente'),
                isExpanded: true,
                items: clientes.map((cliente) {
                  return DropdownMenuItem(
                    value: cliente.id,
                    child: Text(cliente.nome),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => clienteSelecionado = value);
                },
              ),

              const SizedBox(height: 20),

              const Text(
                'Produtos:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              ...produtos.map((produto) {
                _controllers.putIfAbsent(
                  produto.id,
                  () => TextEditingController(
                    text: produtosSelecionados[produto.id]?.toString() ?? "",
                  ),
                );

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(child: Text(produto.nome)),
                      SizedBox(
                        width: 70,
                        child: TextField(
                          controller: _controllers[produto.id],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Qtd',
                          ),
                          onChanged: (value) {
                            final qtd = int.tryParse(value);
                            if (qtd != null && qtd > 0) {
                              produtosSelecionados[produto.id] = qtd;
                            } else {
                              produtosSelecionados.remove(produto.id);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                );
              }),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (clienteSelecionado == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Selecione um cliente')),
                    );
                    return;
                  }

                  if (produtosSelecionados.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Selecione ao menos 1 produto')),
                    );
                    return;
                  }

                  try {
                    vendaService.realizarVenda(
                      clienteId: clienteSelecionado!,
                      produtosComQuantidade: produtosSelecionados,
                    );

                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
                child: const Text('Registrar Venda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
