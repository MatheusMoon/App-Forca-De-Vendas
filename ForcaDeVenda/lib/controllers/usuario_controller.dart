import '../models/usuario.dart';

class UsuarioController {
  static final List<Usuario> _usuarios = [];

  // Adicionar um usuário
  static void addUsuario(Usuario usuario) {
    _usuarios.add(usuario);
  }

  // Excluir um usuário
  static void deleteUsuario(int id) {
    _usuarios.removeWhere((usuario) => usuario.id == id);
  }

  // Retornar todos os usuários
  static List<Usuario> getUsuarios() {
    return _usuarios;
  }
}
