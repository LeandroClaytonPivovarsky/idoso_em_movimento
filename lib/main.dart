import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/core/di/service_locator.dart';
import 'src/features/auth/domain/usecases/login_usecase.dart';
import 'src/features/auth/domain/usecases/register_usecase.dart';
import 'src/features/auth/presentation/cubit/register_cubit.dart';
import 'src/features/auth/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos MultiRepositoryProvider para fornecer mais de um valor
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LoginUseCase>(
          create: (context) => sl<LoginUseCase>(),
        ),
        RepositoryProvider<RegisterUseCase>(
          create: (context) => sl<RegisterUseCase>(),
        ),
        // Também vamos criar o RegisterCubit aqui para ser acessível
        // na tela de registro.
         BlocProvider<RegisterCubit>(
           create: (context) => RegisterCubit(sl<RegisterUseCase>()),
         )
      ],
      child: MaterialApp(
        title: 'Meu App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
      ),
    );
  }
}
