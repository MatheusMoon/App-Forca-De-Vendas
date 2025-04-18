import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void _login(BuildContext context) {
    final usuario = _usuarioController.text;
    final senha = _senhaController.text;

    if (usuario == 'admin' && senha == 'admin') {
      Navigator.pushNamed(context, '/cadastroUsuario');
    } else {
      // Em breve: validar usuário salvo
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Usuário ou senha inválidos')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _usuarioController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
