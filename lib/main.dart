

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:totp_authentication_app/auth/state_controllers/auth_bloc.dart';
// import 'package:totp_authentication_app/modules/home/home_screen.dart';
// import 'package:totp_authentication_app/modules/login/login_screen.dart';
// import 'package:totp_authentication_app/modules/login/topt_code_validation_screen.dart';
// import 'package:totp_authentication_app/project_configs/dio_config/dependency_injector.dart';
// import 'package:totp_authentication_app/auth/state_controllers/auth_wrapper.dart';
// import 'package:totp_authentication_app/auth/state_controllers/auth_events.dart';


// void main() {
//   initializeDependencies();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => sl<AuthBloc>()..add(AuthAppStarted()),
//       child: MaterialApp(
//         title: 'TOTP Auth App',
//         initialRoute: '/',
//         routes: {
//           '/': (context) => const AuthWrapper(),
//           '/login': (context) => const LoginScreen(),
//           '/recovery': (context) => const TOPTCodeValidationScreen(), // Use o nome da sua tela de recuperação aqui
//           '/home': (context) => const HomeScreen(),
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totp_authentication_app/auth/bloc/auth_bloc.dart'; // Corrija o caminho se necessário
import 'package:totp_authentication_app/auth/events/auth_events.dart'; // Corrija o caminho se necessário
import 'package:totp_authentication_app/auth/wrapper/auth_wrapper.dart'; // Corrija o caminho se necessárioimport 'package:totp_authentication_app/modules/home/home_screen.dart';
import 'package:totp_authentication_app/screens/home/home_screen.dart';
import 'package:totp_authentication_app/screens/login/login_screen.dart';
import 'package:totp_authentication_app/screens/topt_code/topt_code_validation_screen.dart';
import 'package:totp_authentication_app/project_configs/dependency/dependency_injector.dart';


void main() {
  initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. O BlocProvider garante que o AuthBloc está disponível para as telas
    return BlocProvider(
      // 2. O create inicia o BLoC e dispara o primeiro evento para verificação
      create: (context) => sl<AuthBloc>()..add(AuthAppStarted()),
      child: MaterialApp(
        title: 'TOTP Auth App',
        debugShowCheckedModeBanner: false,
        
        // 3. A ROTA INICIAL DEVE SER '/' para que o AuthWrapper funcione
        initialRoute: '/',

        // 4. O mapa de rotas define para qual widget cada rota aponta
        routes: {
          '/': (context) => const AuthWrapper(),
          '/login': (context) => const LoginScreen(),
          // Garanta que a rota '/recovery' aponta para a sua tela de validação/recuperação
          '/recovery': (context) => const TOPTCodeValidationScreen(), // Usei um nome genérico, use o nome da sua classe aqui
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}