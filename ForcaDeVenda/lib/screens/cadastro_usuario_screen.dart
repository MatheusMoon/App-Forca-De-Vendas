import 'package:flutter/material.dart';
import '../controllers/usuario_controller.dart';
import '../models/usuario.dart';

class CadastroUsuarioScreen extends StatefulWidget {
  const CadastroUsuarioScreen({super.key});

  @override
  _CadastroUsuarioScreenState createState() => _CadastroUsuarioScreenState();
}

class _CadastroUsuarioScreenState extends State<CadastroUsuarioScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  // Adicionar um novo usuário
  void _addUsuario() {
    final nome = _nomeController.text;
    final senha = _senhaController.text;

    if (nome.isNotEmpty && senha.isNotEmpty) {
      Usuario usuario = Usuario(
        id: DateTime.now().millisecondsSinceEpoch, // Gerando um ID único
        nome: nome,
        senha: senha,
      );

      UsuarioController.addUsuario(usuario);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário cadastrado com sucesso!')),
      );

      _nomeController.clear();
      _senhaController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/cadastroCliente'),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cadastroProduto'),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _addUsuario, child: Text('Cadastrar')),
            SizedBox(height: 20),
            Text(
              'Usuários Cadastrados:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: UsuarioController.getUsuarios().length,
                itemBuilder: (context, index) {
                  final usuario = UsuarioController.getUsuarios()[index];
                  return ListTile(
                    title: Text(usuario.nome),
                    subtitle: Text('Senha: ${usuario.senha}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          UsuarioController.deleteUsuario(usuario.id);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
