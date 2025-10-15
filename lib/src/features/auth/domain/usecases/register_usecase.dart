import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<void> call({
    required String name,
    required String email,
    required String password,
  }) async {
    // Validações poderiam ser adicionadas aqui. Ex:
    if (password.length < 6) {
      throw Exception('A senha deve ter pelo menos 6 caracteres.');
    }
    return await repository.register(name, email, password);
  }
}