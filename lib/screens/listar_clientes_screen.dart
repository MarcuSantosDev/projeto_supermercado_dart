import 'package:flutter/material.dart';
import '../services/cliente_service.dart';
import '../models/cliente.dart';

class ListarClientesScreen extends StatefulWidget {
  final ClienteService clienteService;

  const ListarClientesScreen({super.key, required this.clienteService});

  @override
  State<ListarClientesScreen> createState() => _ListarClientesScreenState();
}

class _ListarClientesScreenState extends State<ListarClientesScreen> {
  List<Cliente> _clientes = [];

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  void _carregar() {
    setState(() {
      _clientes = widget.clienteService.listarTodos();
    });
  }

  void _alternarStatus(Cliente cliente) {
    if (cliente.ativo) {
      widget.clienteService.desativar(cliente.id);
    } else {
      widget.clienteService.ativar(cliente.id);
    }
    _carregar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clientes')),

      body: _clientes.isEmpty
          ? const Center(child: Text('Nenhum cliente cadastrado'))
          : ListView.builder(
              itemCount: _clientes.length,
              itemBuilder: (context, index) {
                final c = _clientes[index];

                return ListTile(
                  leading: Icon(
                    c.ativo ? Icons.check_circle : Icons.cancel,
                    color: c.ativo ? Colors.green : Colors.red,
                  ),
                  title: Text(c.nome),
                  subtitle: Text(c.email),
                  trailing: Text(
                    c.ativo ? 'Ativo' : 'Inativo',
                    style: TextStyle(
                      color: c.ativo ? Colors.green : Colors.red,
                    ),
                  ),

                  onLongPress: () {
                    _alternarStatus(c);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          c.ativo
                              ? 'Cliente desativado'
                              : 'Cliente ativado',
                        ),
                      ),
                    );
                  },
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.pushNamed(context, '/cadastrarCliente');
          _carregar(); // atualizar ao voltar
        },
      ),
    );
  }
}
