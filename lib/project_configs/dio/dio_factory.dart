// import 'package:dio/dio.dart';
// import 'package:totp_authentication_app/project_configs/dio_config/custom_inteceptors.dart';

// class DioFactory {
//   // Este método estático é a única fonte para criar o Dio no app
//   static Dio createDio() { 
//     final dio = Dio(
//       BaseOptions(
//         // URL base para o emulador Android ou seu IP local
//         baseUrl: 'http://127.0.0.1:5000', 
//         connectTimeout: const Duration(seconds: 15),
//         receiveTimeout: const Duration(seconds: 15),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//       ),
//     );

//     // Adiciona nosso interceptor simplificado para logging
//     dio.interceptors.add(CustomInterceptors());

//     return dio;
//   }
// }


import 'package:dio/dio.dart';
import 'package:totp_authentication_app/project_configs/interceptos/custom_inteceptors.dart';

class DioFactory {
  static Dio createDio() { 
    // ▼▼▼ A CORREÇÃO ESTÁ AQUI ▼▼▼
    // 1. Definimos o nome da variável de ambiente que queremos ler.
    const String baseUrlFromEnv = String.fromEnvironment(
      'BASEURL', // O nome DEVE ser exatamente este.
      // 2. Definimos um valor padrão. É ESSENCIAL para rodar o app
      // pela sua IDE (VS Code, Android Studio) sem configurar nada.
    );

    final dio = Dio(
      BaseOptions(
        // 3. Usamos a variável lida do ambiente.
        baseUrl: baseUrlFromEnv, 
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(CustomInterceptors());

    return dio;
  }
}