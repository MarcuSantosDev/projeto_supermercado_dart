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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          brightness: Brightness.light,
          primary: const Color(0xFF2E7D32),
          secondary: const Color(0xFF66BB6A),
          tertiary: const Color(0xFF81C784),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xFF2E7D32),
          foregroundColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
        ),
      ),
    );
  }
}
