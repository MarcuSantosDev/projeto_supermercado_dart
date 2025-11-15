import 'package:flutter/material.dart';
import '../services/cliente_service.dart';

class CadastrarClienteScreen extends StatefulWidget {
  final ClienteService clienteService;

  const CadastrarClienteScreen({super.key, required this.clienteService});

  @override
  State<CadastrarClienteScreen> createState() => _CadastrarClienteScreenState();
}

class _CadastrarClienteScreenState extends State<CadastrarClienteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();

  bool _loading = false;

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      widget.clienteService.cadastrar(
        nome: _nomeController.text,
        email: _emailController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente cadastrado com sucesso!')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Cliente')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.trim().length < 3) {
                    return 'Nome deve ter no mínimo 3 caracteres';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (value == null || !emailRegex.hasMatch(value)) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loading ? null : _salvar,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  