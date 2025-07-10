// import 'package:flutter/material.dart';
// import 'package:otp/otp.dart'; // Importe o OTP para gerar o código
// import 'package:totp_authentication_app/auth/services/auth_services.dart';
// import 'package:totp_authentication_app/project_configs/dio_config/dependency_injector.dart';

// // Função de geração de TOTP para usar no teste de login
// String generateTOTP(String secret) {
//   return OTP.generateTOTPCodeString(
//     secret,
//     DateTime.now().millisecondsSinceEpoch,
//     interval: 30,
//     algorithm: Algorithm.SHA1,
//     isGoogle: true,
//   );
// }

// class ManualApiTestScreen extends StatefulWidget {
//   const ManualApiTestScreen({super.key});

//   @override
//   State<ManualApiTestScreen> createState() => _ManualApiTestScreenState();
// }

// class _ManualApiTestScreenState extends State<ManualApiTestScreen> {
//   // Pega a instância do AuthService (usando get_it como exemplo)
//   late final AuthService _authService;
  
//   String _status = 'Pressione um botão para testar';
//   bool _isLoading = false;
//   String _lastRecoveredSecret = ''; // Para guardar o secret recuperado

//   @override
//   void initState() {
//     super.initState();
//     // Supondo que você inicializou o get_it no seu main.dart
//     _authService = sl<AuthService>(); 
//   }

//   // --- Funções de Teste ---

//   Future<void> _testRecoverSecret() async {
//     setState(() {
//       _isLoading = true;
//       _status = 'Carregando... Testando /recovery-secret';
//     });

//     try {
//       final secret = await _authService.recoverSecret(
//         username: 'admin',
//         password: 'password123',
//         code: '000010', // Código de recuperação correto
//       );

//       setState(() {
//         _status = '✅ SUCESSO!\n\nSecret Recuperado: $secret';
//         _lastRecoveredSecret = secret; // Guarda o secret para o próximo teste
//       });

//     } catch (e) {
//       setState(() {
//         _status = '❌ FALHA!\n\nErro: $e';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _testLogin() async {
//     if (_lastRecoveredSecret.isEmpty) {
//       setState(() {
//         _status = '⚠️ Atenção: Recupere o secret primeiro!';
//       });
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _status = 'Carregando... Testando /login';
//     });

//     try {
//       // Gera o código TOTP com o secret que acabamos de recuperar
//       final totpCode = generateTOTP(_lastRecoveredSecret);

//       await _authService.login(
//         username: 'admin',
//         password: 'password123',
//         totpCode: totpCode,
//       );

//       setState(() {
//         _status = '✅ SUCESSO!\n\nLogin realizado com sucesso.';
//       });

//     } catch (e) {
//       setState(() {
//         _status = '❌ FALHA!\n\nErro: $e';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Teste Manual de API'),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Área para mostrar o status
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   _status,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Indicador de Carregamento
//               if (_isLoading)
//                 const Center(child: CircularProgressIndicator())
//               else
//                 // Botões de Teste
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     ElevatedButton(
//                       onPressed: _testRecoverSecret,
//                       child: const Text('1. Testar Recuperar Secret'),
//                     ),
//                     const SizedBox(height: 12),
//                     ElevatedButton(
//                       onPressed: _testLogin,
//                       child: const Text('2. Testar Login'),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:totp_authentication_app/auth/models/auth_model.dart';
import 'package:totp_authentication_app/auth/services/auth_services.dart';
import 'package:totp_authentication_app/project_configs/dependency/dependency_injector.dart';

// A função generateTOTP permanece a mesma
String generateTOTP(String secret) {
  return OTP.generateTOTPCodeString(
    secret,
    DateTime.now().millisecondsSinceEpoch,
    interval: 30,
    algorithm: Algorithm.SHA1,
    isGoogle: true,
  );
}

class ManualApiTestScreen extends StatefulWidget {
  const ManualApiTestScreen({super.key});

  @override
  State<ManualApiTestScreen> createState() => _ManualApiTestScreenState();
}

class _ManualApiTestScreenState extends State<ManualApiTestScreen> {
  late final AuthService _authService;
  
  String _status = 'Pressione um botão para testar';
  bool _isLoading = false;
  String _lastRecoveredSecret = '';

  @override
  void initState() {
    super.initState();
    _authService = sl<AuthService>(); 
  }

  // --- Funções de Teste Atualizadas ---

  Future<void> _testRecoverSecret() async {
    setState(() {
      _isLoading = true;
      _status = 'Carregando... Testando /recovery-secret';
    });

    try {
      // 2. Criamos o "pacote" de dados usando o nosso model
      final requestData = RecoverSecretRequestModel(
        username: 'admin',
        password: 'password123',
        code: '000010',
      );

      // 3. Passamos o pacote para o serviço
      final secret = await _authService.recoverSecret(recoveryRequest: requestData);

      setState(() {
        _status = '✅ SUCESSO!\n\nSecret Recuperado: $secret';
        _lastRecoveredSecret = secret;
      });

    } catch (e) {
      setState(() {
        _status = '❌ FALHA!\n\nErro: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testLogin() async {
    if (_lastRecoveredSecret.isEmpty) {
      setState(() {
        _status = '⚠️ Atenção: Recupere o secret primeiro!';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _status = 'Carregando... Testando /login';
    });

    try {
      final totpCode = generateTOTP(_lastRecoveredSecret);

      // 2. Criamos o model para a requisição de login
      final requestData = LoginRequestModel(
        username: 'admin',
        password: 'password123',
        totpCode: totpCode,
      );
      
      // 3. Passamos o model para o serviço de login
      await _authService.login(loginRequest: requestData);

      setState(() {
        _status = '✅ SUCESSO!\n\nLogin realizado com sucesso.';
      });

    } catch (e) {
      setState(() {
        _status = '❌ FALHA!\n\nErro: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // A UI (build method) não precisa de nenhuma alteração.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste Manual de API'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _status,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: _testRecoverSecret,
                      child: const Text('1. Testar Recuperar Secret'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _testLogin,
                      child: const Text('2. Testar Login'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}