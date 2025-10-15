import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      // A chamada continua a mesma
      return await localDataSource.login(email, password);
    } on DatabaseException catch (e) {
      // Agora capturamos a exceção correta e repassamos a mensagem dela
      throw Exception(e.message);
    } catch (e) {
      // Captura qualquer outro erro inesperado
      throw Exception('Ocorreu um erro desconhecido.');
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await localDataSource.register(name, email, password);
    } on DatabaseException catch (e) {
       throw Exception(e.message);
    } catch (e) {
      throw Exception('Ocorreu um erro desconhecido ao registrar: ${e.toString()}');
    }
  }
}