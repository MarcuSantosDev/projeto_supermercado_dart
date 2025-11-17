# 🛒 Sistema Supermercado

Sistema completo de gestão de supermercado desenvolvido em Flutter/Dart. Gerencie produtos, clientes e vendas de forma simples e intuitiva.

![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.10+-0175C2?logo=dart&logoColor=white)

## 📋 Índice

* [Funcionalidades](#-funcionalidades)
* [Pré-requisitos](#-pré-requisitos)
* [Instalação](#-instalação)
* [Como Executar](#-como-executar)
* [Dependências](#-dependências)
* [Estrutura do Projeto](#-estrutura-do-projeto)
* [Telas do Sistema](#-telas-do-sistema)
* [Tecnologias Utilizadas](#-tecnologias-utilizadas)

## ✨ Funcionalidades

### 📦 Gestão de Produtos

* ✅ Cadastro de produtos com nome, descrição, preço e estoque
* ✅ Listagem de todos os produtos cadastrados
* ✅ Controle de estoque automático
* ✅ Status de ativação/desativação de produtos

### 👥 Gestão de Clientes

* ✅ Cadastro de clientes com nome e email
* ✅ Listagem de todos os clientes

### 🛍️ Gestão de Vendas

* ✅ Registro de vendas com múltiplos produtos
* ✅ Seleção de cliente e produtos
* ✅ Cálculo automático de totais e subtotais
* ✅ Controle de estoque durante a venda
* ✅ Histórico completo de vendas
* ✅ Status de vendas (Pendente, Confirmada, Cancelada)

### 📊 Dashboard

* ✅ Visão geral com estatísticas
* ✅ Contadores de produtos, clientes e vendas
* ✅ Faturamento total
* ✅ Interface moderna e intuitiva

## 🔧 Pré-requisitos

Antes de começar, certifique-se de ter instalado:

* **Flutter SDK** (versão 3.10.0 ou superior)
* **Dart SDK** (versão 3.10.0 ou superior)
* **Git** (para clonar o repositório)
* **Um editor de código** (VS Code, Android Studio, IntelliJ IDEA)
* **Android Studio** ou **Xcode** (para desenvolvimento mobile)

### Verificando a Instalação

Para verificar se o Flutter está instalado corretamente, execute:

```bash
flutter --version
flutter doctor
```

O comando `flutter doctor` verificará se todas as dependências estão configuradas corretamente.

## 📥 Instalação

### 1. Clone o repositório

```bash
git clone <url-do-repositório>
cd projeto_supermercado
```

### 2. Instale as dependências

```bash
flutter pub get
```

Este comando irá baixar e instalar todas as dependências listadas no arquivo `pubspec.yaml`.

### 3. Verifique se tudo está configurado

```bash
flutter doctor
```

Certifique-se de que todas as ferramentas necessárias estão instaladas e configuradas.

## 🚀 Como Executar

### Executar no Emulador/Dispositivo

1. **Liste os dispositivos disponíveis:**

   ```bash
   flutter devices
   ```

2. **Execute o aplicativo:**

   ```bash
   flutter run
   ```

   Ou especifique um dispositivo:

   ```bash
   flutter run -d <device-id>
   ```

### Executar em Modo de Desenvolvimento

```bash
flutter run --debug
```

### Executar em Modo de Release

```bash
flutter run --release
```

### Executar em Plataformas Específicas

#### Android

```bash
flutter run -d android
```

#### iOS (apenas no macOS)

```bash
flutter run -d ios
```

#### Web

```bash
flutter run -d chrome
```

#### Windows

```bash
flutter run -d windows
```

#### Linux

```bash
flutter run -d linux
```

#### macOS

```bash
flutter run -d macos
```

## 📦 Dependências

### Dependências Principais

O projeto utiliza as seguintes dependências principais:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
```

### Dependências de Desenvolvimento

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
```

### Descrição das Dependências

* **flutter**: Framework principal do Flutter
* **cupertino_icons**: Ícones no estilo iOS/Cupertino
* **flutter_test**: Framework de testes do Flutter
* **flutter_lints**: Regras de linting recomendadas para Flutter

### Atualizando Dependências

Para atualizar todas as dependências para suas versões mais recentes:

```bash
flutter pub upgrade
```

## 📁 Estrutura do Projeto

```
projeto_supermercado/
├── lib/
│   ├── main.dart                 # Ponto de entrada da aplicação
│   ├── globals.dart              # Instâncias globais de serviços e repositórios
│   ├── models/                   # Modelos de dados
│   │   ├── cliente.dart
│   │   ├── produto.dart
│   │   ├── venda.dart
│   │   └── item_venda.dart
│   ├── repositories/             # Camada de repositório (persistência)
│   │   ├── cliente_repository.dart
│   │   ├── produto_repository.dart
│   │   └── venda_repository.dart
│   ├── services/                 # Camada de serviços (lógica de negócio)
│   │   ├── cliente_service.dart
│   │   ├── produto_service.dart
│   │   └── venda_service.dart
│   └── screens/                  # Telas da aplicação
│       ├── home_screen.dart
│       ├── cadastrar_cliente_screen.dart
│       ├── cadastrar_produto_screen.dart
│       ├── listar_clientes_screen.dart
│       ├── listar_produtos_screen.dart
│       ├── listar_vendas_screen.dart
│       └── registrar_venda_screen.dart
├── android/                      # Configurações Android
├── ios/                          # Configurações iOS
├── web/                          # Configurações Web
├── windows/                      # Configurações Windows
├── linux/                        # Configurações Linux
├── macos/                        # Configurações macOS
├── test/                         # Testes unitários
├── pubspec.yaml                  # Arquivo de configuração e dependências
├── pubspec.lock                  # Lock file das dependências
├── analysis_options.yaml         # Configurações de análise de código
└── README.md                     # Este arquivo
```

## 🖥️ Telas do Sistema

### 🏠 Tela Inicial (Home)

* Dashboard com estatísticas gerais
* Cards de navegação para todas as funcionalidades
* Visão rápida de produtos, clientes e vendas

### 📦 Gestão de Produtos

* **Listar Produtos**: Visualização em cards com informações detalhadas
* **Cadastrar Produto**: Formulário completo com validações

### 👥 Gestão de Clientes

* **Listar Clientes**: Lista com status ativo/inativo
* **Cadastrar Cliente**: Formulário com validação de email

### 🛍️ Gestão de Vendas

* **Listar Vendas**: Histórico completo com detalhes
* **Registrar Venda**: Interface intuitiva para seleção de cliente e produtos

## 🛠️ Tecnologias Utilizadas

* **Flutter**: Framework multiplataforma para desenvolvimento de aplicativos
* **Dart**: Linguagem de programação
* **Material Design 3**: Design system moderno e responsivo
* **Arquitetura em Camadas**: Separação clara entre Models, Repositories, Services e Screens

## 🎨 Design

O aplicativo utiliza Material Design 3 com:

* Tema verde personalizado
* Cards modernos e arredondados
* Ícones intuitivos
* Animações suaves
* Interface responsiva

## 📝 Notas Importantes

* Os dados são armazenados em memória (não há persistência em banco de dados)
* Ao reiniciar o aplicativo, todos os dados serão perdidos

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.

## 👨‍💻 Autores

Desenvolvido por Marcus Vinícius e Iago Pablo
