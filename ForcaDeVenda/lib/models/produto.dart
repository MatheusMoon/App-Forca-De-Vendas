class Produto {
  final int id;
  final String nome;
  final String unidade; // un, cx, kg, lt, ml
  final double quantidadeEstoque;
  final double precoVenda;
  final int status; // 0 - Ativo, 1 - Inativo
  final double? custo;
  final String? codigoBarra;

  Produto({
    required this.id,
    required this.nome,
    required this.unidade,
    required this.quantidadeEstoque,
    required this.precoVenda,
    required this.status,
    this.custo,
    this.codigoBarra,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'unidade': unidade,
      'quantidadeEstoque': quantidadeEstoque,
      'precoVenda': precoVenda,
      'status': status,
      'custo': custo,
      'codigoBarra': codigoBarra,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    final status = map['status'] as int;
    if (status != 0 && status != 1) {
      throw FormatException(
        'Status inválido: $status. Deve ser 0 (Ativo) ou 1 (Inativo).',
      );
    }
    return Produto(
      id: map['id'] as int,
      nome: map['nome'] as String,
      unidade: map['unidade'] as String,
      quantidadeEstoque: (map['quantidadeEstoque'] as num).toDouble(),
      precoVenda: (map['precoVenda'] as num).toDouble(),
      status: status,
      custo: map['custo'] as double?,
      codigoBarra: map['codigoBarra'] as String?,
    );
  }
}
