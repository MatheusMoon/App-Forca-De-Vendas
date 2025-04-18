import 'package:flutter/material.dart';

class CadastroClienteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Cliente'),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () => Navigator.pushNamed(context, '/cadastroUsuario'),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cadastroProduto'),
          ),
        ],
      ),
      body: Center(child: Text('Tela de Cadastro de Cliente')),
    );
  }
}
