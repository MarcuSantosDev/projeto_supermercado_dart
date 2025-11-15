import 'package:flutter/material.dart';

import 'globals.dart';

import 'screens/home_screen.dart';
import 'screens/listar_produtos_screen.dart';
import 'screens/cadastrar_produto_screen.dart';
import 'screens/listar_vendas_screen.dart';
import 'screens/registrar_venda_screen.dart';
import 'screens/cadastrar_cliente_screen.dart';
import 'screens/listar_clientes_screen.dart';

void main() {
  runApp(const SupermercadoApp());
}

class SupermercadoApp extends StatelessWidget {
  const SupermercadoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema Supermercado',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {

        '/home': (context) => const HomeScreen(),

        '/produtos/listar': (context) => const ListarProdutosScreen(),
        '/produtos/cadastrar': (context) => const CadastrarProdutoScreen(),

        '/vendas/listar': (context) => const ListarVendasScreen(),
        '/vendas/registrar': (context) => const RegistrarVendaScreen(),


        '/clientes/cadastrar': (context) =>
            CadastrarClienteScreen(clienteService: clienteService),
        '/clientes/listar': (context) =>
            ListarClientesScreen(clienteService: clienteService),
      },

      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
