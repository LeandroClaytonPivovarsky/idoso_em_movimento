import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './register_page.dart';
import '../cubit/login_cubit.dart';
import '../../domain/usecases/login_usecase.dart';

// CRIE UMA TELA DE HOME SIMPLES PARA NAVEGARMOS ATÉ ELA
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Bem-vindo à Home!")),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController(text: 'test@test.com');
  final _passwordController = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        // AQUI VOCÊ DEVERIA USAR INJEÇÃO DE DEPENDÊNCIA (get_it)
        // Mas para ser rápido, vamos instanciar diretamente
        create: (context) => LoginCubit(
          // Essa construção manual será substituída pela injeção de dependência
          // LoginUseCase(AuthRepositoryImpl(remoteDataSource: AuthRemoteDataSourceImpl()))
          // POR ENQUANTO, DEIXE ASSIM, VAMOS ARRUMAR NO MAIN.DART
          context.read<LoginUseCase>(),
        ),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              // Navega para a home em caso de sucesso
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            } else if (state is LoginFailure) {
              // Mostra um Snackbar em caso de falha
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    // Desabilita o botão enquanto está carregando
                    onPressed: state is LoginLoading
                        ? null
                        : () {
                            // Chama a função de login do Cubit
                            context.read<LoginCubit>().login(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                          },
                    child: state is LoginLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Text('Entrar'),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => RegisterPage()),
                      );
                    },
                    child: const Text('Não tem uma conta? Crie uma!'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
