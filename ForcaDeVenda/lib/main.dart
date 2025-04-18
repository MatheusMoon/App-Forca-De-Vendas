import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/cadastro_usuario_screen.dart';
import 'screens/cadastro_cliente_screen.dart';
import 'screens/cadastro_produto_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Força de Vendas',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/cadastroUsuario': (context) => CadastroUsuarioScreen(),
        '/cadastroCliente': (context) => CadastroClienteScreen(),
        '/cadastroProduto': (context) => CadastroProdutoScreen(),
      },
    );
  }
}
