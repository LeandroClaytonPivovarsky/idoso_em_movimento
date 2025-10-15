import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(localDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl());

  // Extern (Banco de dados)
  // Registra a instância da "caixa" do Hive que abrimos no main.dart
  sl.registerLazySingleton<Box<UserModel>>(() => Hive.box<UserModel>('users'));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
}