class UserModel {
  final String nome;
  final String endereco;
  final String cpf;
  final String interesses;
  final String documentoPath; // Caminho do arquivo enviado (imagem)

  const UserModel({
    required this.nome,
    required this.endereco,
    required this.cpf,
    required this.interesses,
    required this.documentoPath,
  });

  UserModel copyWith({
    String? nome,
    String? endereco,
    String? cpf,
    String? interesses,
    String? documentoPath,
  }) {
    return UserModel(
      nome: nome ?? this.nome,
      endereco: endereco ?? this.endereco,
      cpf: cpf ?? this.cpf,
      interesses: interesses ?? this.interesses,
      documentoPath: documentoPath ?? this.documentoPath,
    );
  }
}
