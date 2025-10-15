import '../../../../core/data/db_connection.dart';
import '../models/user_model.dart';

// Exceção customizada
class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);
}

abstract class AuthLocalDataSource {
  Future<UserModel> login(String email, String password); // Adicionamos de volta
  Future<void> register(String name, String email, String password);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {

  @override
  Future<UserModel> login(String email, String password) async {
    final conn = await DbConnection.getConnection();
    try {
      final results = await conn.query(
        'SELECT id, name, email, password FROM users WHERE email = ?',
        [email],
      );

      if (results.isEmpty) {
        throw DatabaseException('Usuário não encontrado.');
      }

      final userRow = results.first;

      // Em um app real, aqui seria a verificação de hash da senha
      if (userRow['password'] != password) {
        throw DatabaseException('Senha incorreta.');
      }

      // Se passou por tudo, cria e retorna o UserModel
      return UserModel(
        id: userRow['id'].toString(),
        name: userRow['name'] as String,
        email: userRow['email'] as String,
      );
    } catch (e) {
      // Re-lança a exceção para ser tratada no repositório
      throw DatabaseException(e.toString());
    } finally {
      await conn.close();
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    final conn = await DbConnection.getConnection();
    try {
      await conn.query(
        'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
        [name, email, password],
      );
    } catch (e) {
      throw DatabaseException('Erro ao registrar usuário: ${e.toString()}');
    } finally {
      await conn.close();
    }
  }
}