class Cliente {
  final int id;
  final String nome;
  final String email;

  Cliente({required this.id, required this.nome, required this.email});

  @override
  String toString() => 'Cliente(id: $id, nome: $nome, email: $email)';
}
