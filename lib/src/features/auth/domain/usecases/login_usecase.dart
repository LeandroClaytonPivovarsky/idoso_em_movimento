import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call({required String email, required String password}) async {
    // Aqui poderiam ter regras de negócio, como validar o formato do email
    return await repository.login(email, password);
  }
}