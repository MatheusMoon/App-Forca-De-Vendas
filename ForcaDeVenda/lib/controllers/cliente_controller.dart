import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/cliente.dart';

class ClienteController {
  static Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/clientes.json';
  }

  static Future<List<Cliente>> _readClientes() async {
    try {
      final file = File(await _getFilePath());
      if (!await file.exists()) return [];
      final String contents = await file.readAsString();
      final List<dynamic> json = jsonDecode(contents);
      return json.map((e) => Cliente.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> _writeClientes(List<Cliente> clientes) async {
    final file = File(await _getFilePath());
    final String json = jsonEncode(clientes.map((e) => e.toMap()).toList());
    await file.writeAsString(json);
  }

  static Future<void> addCliente(Cliente cliente) async {
    final clientes = await _readClientes();
    clientes.add(cliente);
    await _writeClientes(clientes);
  }

  static Future<void> updateCliente(Cliente cliente) async {
    final clientes = await _readClientes();
    final index = clientes.indexWhere((c) => c.id == cliente.id);
    if (index != -1) {
      clientes[index] = cliente;
      await _writeClientes(clientes);
    }
  }

  static Future<void> deleteCliente(int id) async {
    final clientes = await _readClientes();
    clientes.removeWhere((c) => c.id == id);
    await _writeClientes(clientes);
  }

  static Future<List<Cliente>> getClientes() async {
    return await _readClientes();
  }
}
