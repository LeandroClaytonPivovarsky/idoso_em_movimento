import '../../../../core/data/db_connection.dart';
import '../models/user_model.dart'; // Importe o UserModel que acabamos de criar

// Exceções customizadas
class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);
}

// --- INTERFACE (O CONTRATO) ---
// A classe abstrata apenas define QUAIS métodos devem existir.
abstract class AuthLocalDataSource {
  Future<UserModel> login(String email, String password);
  Future<void> register(String name, String email, String password);
}

// --- IMPLEMENTAÇÃO (COMO OS MÉTODOS FUNCIONAM) ---
// A classe de implementação de fato executa a lógica.
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

      final userRow = results.first.fields;

      if (userRow['password'] != password) {
        throw DatabaseException('Senha incorreta.');
      }

      // Faltava esta linha!
      // Retornamos um UserModel criado a partir dos dados do banco.
      return UserModel.fromMap(userRow);

    } catch (e) {
      // Relança a exceção para a camada do repositório
      throw DatabaseException(e.toString());
    } finally {
      // Faltava o finally para garantir que a conexão sempre feche!
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