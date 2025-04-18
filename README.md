# Força de Venda - Aplicativo Flutter

Este projeto é um **Aplicativo de Força de Venda** desenvolvido em Flutter, conforme os requisitos solicitados no trabalho acadêmico. Ele implementa a funcionalidade de cadastro de **Usuários**, **Clientes** e **Produtos**, com operações de **CRUD** (Create, Read, Update, Delete), e armazena os dados em arquivos **JSON** para persistência local.

## Funcionalidades

1. **Tela de Login**  
   - Validação de usuário com login **admin/admin** ou qualquer usuário previamente cadastrado.  

2. **Cadastro de Usuários**  
   - Registro de **Usuários** com ID, Nome e Senha.  
   - CRUD completo de Usuários.  

3. **Cadastro de Clientes**  
   - Registro de **Clientes** com ID, Nome, Tipo (Física ou Jurídica), CPF/CNPJ, E-mail, Telefone, CEP, Endereço, Bairro, Cidade e UF.  
   - CRUD completo de Clientes.  

4. **Cadastro de Produtos**  
   - Registro de **Produtos** com ID, Nome, Unidade (un, cx, kg, lt, ml), Quantidade de Estoque, Preço de Venda, Status e Código de Barra.  
   - CRUD completo de Produtos.  

5. **Persistência de Dados**  
   - Os dados são armazenados em arquivos **JSON** separados para cada entidade (`usuarios.json`, `clientes.json`, `produtos.json`), garantindo que os dados se mantenham mesmo após fechar o aplicativo e abrir novamente.  

6. **Validação de Campos**  
   - Os campos obrigatórios nos cadastros são validados para garantir que não sejam deixados em branco.  

## Tecnologias Utilizadas

- **Flutter**  
- **Dart**  
- **JSON**  

## Membros
   - Matheus Cordeiro - 22217014
   - Vitor Saar - 122100011

## Como Rodar o Projeto

1. **Pré-requisitos**  
   - Instale o [Flutter](https://flutter.dev/docs/get-started/install)  
   - Android Studio ou VS Code  
   - Emulador Android configurado ou dispositivo físico  

2. **Clone o repositório**  
   ```bash
   git clone https://github.com/seu_usuario/seu_repositorio.git
   cd seu_repositorio
