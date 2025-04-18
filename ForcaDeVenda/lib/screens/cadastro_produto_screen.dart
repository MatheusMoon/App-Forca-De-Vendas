import 'package:flutter/material.dart';
import '../controllers/produto_controller.dart';
import '../models/produto.dart';

class CadastroProdutoScreen extends StatefulWidget {
  const CadastroProdutoScreen({super.key});

  @override
  _CadastroProdutoScreenState createState() => _CadastroProdutoScreenState();
}

class _CadastroProdutoScreenState extends State<CadastroProdutoScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _unidadeController = TextEditingController();
  final TextEditingController _qtdEstoqueController = TextEditingController();
  final TextEditingController _precoVendaController = TextEditingController();
  final TextEditingController _custoController = TextEditingController();
  final TextEditingController _codigoBarraController = TextEditingController();
  int _status = 0;
  int? _editingId;

  void _saveProduto() {
    // Validações de campos obrigatórios
    if (_nomeController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Nome é obrigatório')));
      return;
    }
    if (_unidadeController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Unidade é obrigatória')));
      return;
    }
    if (_qtdEstoqueController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quantidade em Estoque é obrigatória')),
      );
      return;
    }
    if (_precoVendaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preço de Venda é obrigatório')),
      );
      return;
    }

    // Validação adicional para unidade
    const validUnits = ['un', 'cx', 'kg', 'lt', 'ml'];
    if (!validUnits.contains(_unidadeController.text.toLowerCase())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unidade deve ser: un, cx, kg, lt ou ml')),
      );
      return;
    }

    try {
      final qtdEstoque = int.parse(_qtdEstoqueController.text);
      final precoVenda = double.parse(_precoVendaController.text);

      if (qtdEstoque < 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Quantidade em Estoque não pode ser negativa'),
          ),
        );
        return;
      }
      if (precoVenda <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Preço de Venda deve ser maior que zero'),
          ),
        );
        return;
      }

      final produto = Produto(
        id: _editingId ?? DateTime.now().millisecondsSinceEpoch,
        nome: _nomeController.text,
        unidade: _unidadeController.text,
        quantidadeEstoque: qtdEstoque.toDouble(),
        precoVenda: precoVenda,
        status: _status,
        custo: double.tryParse(_custoController.text) ?? 0.0,
        codigoBarra:
            _codigoBarraController.text.isNotEmpty
                ? _codigoBarraController.text
                : null,
      );

      if (_editingId == null) {
        ProdutoController.addProduto(produto);
      } else {
        ProdutoController.updateProduto(produto);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Produto ${_editingId == null ? 'cadastrado' : 'atualizado'} com sucesso!',
          ),
        ),
      );

      // Limpar formulário e atualizar a lista
      setState(() {
        _nomeController.clear();
        _unidadeController.clear();
        _qtdEstoqueController.clear();
        _precoVendaController.clear();
        _custoController.clear();
        _codigoBarraController.clear();
        _status = 0;
        _editingId = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao salvar produto: $e')));
    }
  }

  void _editProduto(Produto produto) {
    setState(() {
      _nomeController.text = produto.nome;
      _unidadeController.text = produto.unidade;
      _qtdEstoqueController.text = produto.quantidadeEstoque.toInt().toString();
      _precoVendaController.text = produto.precoVenda.toString();
      _custoController.text = produto.custo?.toString() ?? '';
      _codigoBarraController.text = produto.codigoBarra ?? '';
      _status = produto.status;
      _editingId = produto.id;
    });
  }

  void _clearForm() {
    setState(() {
      _nomeController.clear();
      _unidadeController.clear();
      _qtdEstoqueController.clear();
      _precoVendaController.clear();
      _custoController.clear();
      _codigoBarraController.clear();
      _status = 0;
      _editingId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _editingId == null ? 'Cadastro de Produto' : 'Editar Produto',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => Navigator.pushNamed(context, '/cadastroUsuario'),
          ),
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: () => Navigator.pushNamed(context, '/cadastroCliente'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome *'),
              ),
              TextField(
                controller: _unidadeController,
                decoration: const InputDecoration(
                  labelText: 'Unidade * (un, cx, kg, lt, ml)',
                ),
              ),
              TextField(
                controller: _qtdEstoqueController,
                decoration: const InputDecoration(
                  labelText: 'Quantidade em Estoque *',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _precoVendaController,
                decoration: const InputDecoration(
                  labelText: 'Preço de Venda *',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              TextField(
                controller: _custoController,
                decoration: const InputDecoration(labelText: 'Custo'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              TextField(
                controller: _codigoBarraController,
                decoration: const InputDecoration(labelText: 'Código de Barra'),
              ),
              DropdownButtonFormField<int>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status *'),
                items: const [
                  DropdownMenuItem(value: 0, child: Text('Ativo')),
                  DropdownMenuItem(value: 1, child: Text('Inativo')),
                ],
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _saveProduto,
                    child: Text(_editingId == null ? 'Cadastrar' : 'Atualizar'),
                  ),
                  ElevatedButton(
                    onPressed: _clearForm,
                    child: const Text('Limpar'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Produtos Cadastrados:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<Produto>>(
                future: ProdutoController.getProdutos(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final produtos = snapshot.data!;
                  if (produtos.isEmpty) {
                    return const Center(
                      child: Text('Nenhum produto cadastrado.'),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: produtos.length,
                    itemBuilder: (context, index) {
                      final produto = produtos[index];
                      return ListTile(
                        title: Text(produto.nome),
                        subtitle: Text(
                          'Preço: ${produto.precoVenda.toStringAsFixed(2)} | Estoque: ${produto.quantidadeEstoque.toInt()}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _editProduto(produto),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                ProdutoController.deleteProduto(produto.id);
                                setState(() {}); // Atualizar a lista
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _unidadeController.dispose();
    _qtdEstoqueController.dispose();
    _precoVendaController.dispose();
    _custoController.dispose();
    _codigoBarraController.dispose();
    super.dispose();
  }
}
