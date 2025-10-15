import '../../domain/entities/user_entity.dart';

// UserModel pertence à camada de DADOS. Ele pode ter lógicas
// específicas de conversão de dados (como vir de um JSON ou, no nosso caso, de um mapa do DB).
// Ele estende a UserEntity para garantir que possui os mesmos campos que a camada de domínio espera.
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  // Um "construtor de fábrica" para criar um UserModel a partir de um mapa
  // que vem da nossa consulta ao banco de dados.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'].toString(),
      name: map['name'],
      email: map['email'],
    );
  }
}