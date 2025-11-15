class Cliente {
  final String id;
  final String nome;
  final String email;
  final DateTime dataCadastro;
  final bool ativo;

  Cliente({
    required this.id,
    required this.nome,
    required this.email,
    DateTime? dataCadastro,
    this.ativo = true,
  }) : dataCadastro = dataCadastro ?? DateTime.now();

  Cliente copyWith({
    String? id,
    String? nome,
    String? email,
    DateTime? dataCadastro,
    bool? ativo,
  }) {
    return Cliente(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      dataCadastro: dataCadastro ?? this.dataCadastro,
      ativo: ativo ?? this.ativo,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'email': email,
    'dataCadastro': dataCadastro.toIso8601String(),
    'ativo': ativo,
  };

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
    id: json['id'] as String,
    nome: json['nome'] as String,
    email: json['email'] as String,
    dataCadastro: DateTime.parse(json['dataCadastro'] as String),
    ativo: json['ativo'] as bool? ?? true,
  );

  @override
  String toString() =>
      'Cliente(id: $id, nome: $nome, email: $email, ativo: $ativo)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cliente && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
