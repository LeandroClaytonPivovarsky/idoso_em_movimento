import 'package:mysql1/mysql1.dart';

class DbConnection {
  static Future<MySqlConnection> getConnection() async {
    
    final settings = ConnectionSettings(
      host: '127.0.0.1', // <-- IMPORTANTE! LEIA A OBSERVAÇÃO ABAIXO
      port: 3306,
      user: 'aluno',      // Seu usuário do MySQL (padrão do XAMPP/LAMPP)
      password: 'alunoifpr',    // Sua senha (padrão é vazia)
      db: 'test_db' 
    );

    return await MySqlConnection.connect(settings);
  }
}