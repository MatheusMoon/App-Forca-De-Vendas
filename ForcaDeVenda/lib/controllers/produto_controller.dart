import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/produto.dart';

class ProdutoController {
  static Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/produtos.json';
  }

  static Future<List<Produto>> _readProdutos() async {
    try {
      final file = File(await _getFilePath());
      if (!await file.exists()) return [];
      final String contents = await file.readAsString();
      final List<dynamic> json = jsonDecode(contents);
      return json.map((e) => Produto.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> _writeProdutos(List<Produto> produtos) async {
    final file = File(await _getFilePath());
    final String json = jsonEncode(produtos.map((e) => e.toMap()).toList());
    await file.writeAsString(json);
  }

  static Future<void> addProduto(Produto produto) async {
    final produtos = await _readProdutos();
    produtos.add(produto);
    await _writeProdutos(produtos);
  }

  static Future<void> updateProduto(Produto produto) async {
    final produtos = await _readProdutos();
    final index = produtos.indexWhere((p) => p.id == produto.id);
    if (index != -1) {
      produtos[index] = produto;
      await _writeProdutos(produtos);
    }
  }

  static Future<void> deleteProduto(int id) async {
    final produtos = await _readProdutos();
    produtos.removeWhere((p) => p.id == id);
    await _writeProdutos(produtos);
  }

  static Future<List<Produto>> getProdutos() async {
    return await _readProdutos();
  }
}
