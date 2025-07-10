

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:otp/otp.dart';
// import 'package:totp_authentication_app/auth/models/auth_model.dart';

// // 1. Imports corrigidos para apontar para os arquivos corretos do seu projeto
// import 'package:totp_authentication_app/auth/services/auth_services.dart';
// import 'package:totp_authentication_app/project_configs/secret/secret_repository.dart';
// import 'package:totp_authentication_app/auth/state_controllers/auth_events.dart';
// import 'package:totp_authentication_app/auth/state_controllers/auth_state.dart';

// /// Função auxiliar para gerar o código TOTP com base no secret.
// String generateTOTP(String secret) {
//   return OTP.generateTOTPCodeString(
//     secret,
//     DateTime.now().millisecondsSinceEpoch,
//     interval: 30,
//     algorithm: Algorithm.SHA1,
//     isGoogle: true,
//   );
// }

// // O nome da sua classe BLoC
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthService authService;
//   final SecretRepository secretRepository;

//   AuthBloc({required this.authService, required this.secretRepository}) : super(AuthInitial()) {
//     // Registra um "handler" para cada evento que o BLoC pode receber
//     on<AuthAppStarted>(_onAppStarted);
//     on<AuthUsernameChanged>(_onUsernameChanged);
//     on<AuthPasswordChanged>(_onPasswordChanged);
//     on<AuthLoginSubmitted>(_onLoginSubmitted);
//     on<AuthSecretRecoveryRequested>(_onSecretRecoveryRequested);
//   }

//   /// Chamado quando o app inicia para decidir a rota inicial.
//   Future<void> _onAppStarted(AuthAppStarted event, Emitter<AuthState> emit) async {
//     final secret = await secretRepository.getSecret();
//     if (secret == null || secret.isEmpty) {
//       emit(AuthRequiresSecretRecovery());
//     } else {
//       emit(const AuthReadyToLogin(username: '', password: ''));
//     }
//   }

//   /// Atualiza o estado sempre que o campo de usuário muda.
//   void _onUsernameChanged(AuthUsernameChanged event, Emitter<AuthState> emit) {
//     emit(AuthReadyToLogin(username: event.username, password: state.password));
//   }

//   /// Atualiza o estado sempre que o campo de senha muda.
//   void _onPasswordChanged(AuthPasswordChanged event, Emitter<AuthState> emit) {
//     emit(AuthReadyToLogin(username: state.username, password: event.password));
//   }

//   /// Executa a lógica de login quando o evento de submissão é recebido.
//   Future<void> _onLoginSubmitted(AuthLoginSubmitted event, Emitter<AuthState> emit) async {
//     // Mantém os dados do formulário no estado de loading para a UI não piscar
//     emit(AuthLoading(username: state.username, password: state.password));
//     try {
//       final secret = await secretRepository.getSecret();
//       if (secret == null) {
//         throw Exception("Secret não encontrado. Recupere o secret primeiro.");
//       }

//       final totpCode = generateTOTP(secret);

//       // Cria o model com os dados que estão no estado atual do BLoC
//       final loginData = LoginRequestModel(
//         username: state.username,
//         password: state.password,
//         totpCode: totpCode,
//       );
      
//       // Passa o model para o serviço
//       await authService.login(loginRequest: loginData);

//       emit(AuthSuccess());
//     } catch (e) {
//       // Em caso de falha, emite o erro mas mantém os dados do formulário
//       emit(AuthFailure(e.toString(), username: state.username, password: state.password));
//     }
//   }

//   /// Executa a lógica de recuperação de secret.
//   Future<void> _onSecretRecoveryRequested(AuthSecretRecoveryRequested event, Emitter<AuthState> emit) async {
//     emit(AuthLoading(username: state.username, password: state.password));
//     try {
//       // Cria o model para a requisição de recuperação
//       final recoveryData = RecoverSecretRequestModel(
//         username: "admin",
//         password: "password123",
//         code: event.recoveryCode,
//       );

//       final secret = await authService.recoverSecret(recoveryRequest: recoveryData);
      
//       await secretRepository.saveSecret(secret);

//       // Após sucesso, emite o estado que levará o usuário para a tela de login
//       emit(const AuthReadyToLogin(username: 'admin', password: ''));
//     } catch (e) {
//       emit(AuthFailure(e.toString(), username: state.username, password: state.password));
//       // Após a falha na recuperação, mantém o usuário na tela de recuperação
//       emit(AuthRequiresSecretRecovery());
//     }
// //   } }

// // ======================================================================================
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:otp/otp.dart';
// import 'package:totp_authentication_app/auth/models/auth_model.dart';
// import 'package:totp_authentication_app/auth/services/auth_services.dart';
// import 'package:totp_authentication_app/project_configs/secret/secret_repository.dart';
// import 'package:totp_authentication_app/auth/state_controllers/auth_events.dart';
// import 'package:totp_authentication_app/auth/state_controllers/auth_state.dart';

// /// Função auxiliar para gerar o código TOTP com base no secret.
// String generateTOTP(String secret) {
//   return OTP.generateTOTPCodeString(
//     secret,
//     DateTime.now().millisecondsSinceEpoch,
//     interval: 30,
//     algorithm: Algorithm.SHA1,
//     isGoogle: true,
//   );
// }

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthService authService;
//   final SecretRepository secretRepository;

//   AuthBloc({required this.authService, required this.secretRepository}) : super(AuthInitial()) {
//     on<AuthAppStarted>(_onAppStarted);
//     on<AuthUsernameChanged>(_onUsernameChanged);
//     on<AuthPasswordChanged>(_onPasswordChanged);
//     on<AuthLoginSubmitted>(_onLoginSubmitted);
//     on<AuthSecretRecoveryRequested>(_onSecretRecoveryRequested);
//   }

//   /// Garante que o app sempre comece na tela de login.
//   Future<void> _onAppStarted(AuthAppStarted event, Emitter<AuthState> emit) async {
//     emit(const AuthReadyToLogin(username: 'admin', password: 'password123'));
//   }

//   void _onUsernameChanged(AuthUsernameChanged event, Emitter<AuthState> emit) {
//     emit(AuthReadyToLogin(username: event.username, password: state.password));
//   }

//   void _onPasswordChanged(AuthPasswordChanged event, Emitter<AuthState> emit) {
//     emit(AuthReadyToLogin(username: state.username, password: event.password));
//   }

//   /// Executa a lógica de login com o mecanismo de autocorreção e diagnóstico.
//   Future<void> _onLoginSubmitted(AuthLoginSubmitted event, Emitter<AuthState> emit) async {
//     // CHECKPOINT 1: O método foi chamado?
//     print("✅ CHECKPOINT 1: _onLoginSubmitted iniciado.");
    
//     emit(AuthLoading(username: state.username, password: state.password));
//     try {
//       final secret = await secretRepository.getSecret();

//       // CHECKPOINT 2: O que foi encontrado no armazenamento local?
//       print("✅ CHECKPOINT 2: Secret local lido. Valor: '$secret'");

//       if (secret == null || secret.isEmpty) {
//         // CHECKPOINT 3: O código entrou no desvio?
//         print("🔴 DESVIO: Secret não encontrado. Iniciando fluxo de recuperação. Nenhuma chamada à API de login será feita.");
        
//         emit(const AuthRequiresSecretRecovery());
//         await Future.delayed(const Duration(milliseconds: 100));
//         emit(AuthReadyToLogin(username: state.username, password: state.password));
//         return;
//       }

//       // CHECKPOINT 4: Se chegou aqui, a chamada à API deveria acontecer.
//       print("✅ CHECKPOINT 4: Secret encontrado. Preparando para chamar a API de login...");

//       final totpCode = generateTOTP(secret);
//       final loginData = LoginRequestModel(
//         username: state.username,
//         password: state.password,
//         totpCode: totpCode,
//       );
      
//       await authService.login(loginRequest: loginData);
//       print("✅ CHECKPOINT 5: Chamada à API de login realizada com sucesso.");
//       emit(AuthSuccess());

//     } catch (e) {
//       // CHECKPOINT DE ERRO: Alguma exceção foi capturada?
//       print("🔴 ERRO: Ocorreu uma exceção no bloco try/catch: $e");
      
//       if (e.toString().contains("Invalid TOTP code")) {
//         emit(AuthFailure("Chave de acesso expirou. Por favor, recupere sua conta.", username: state.username, password: state.password));
        
//         await secretRepository.deleteSecret();
//         emit(const AuthRequiresSecretRecovery());
        
//         await Future.delayed(const Duration(milliseconds: 100));
//         emit(AuthReadyToLogin(username: state.username, password: state.password));

//       } else {
//         emit(AuthFailure(e.toString(), username: state.username, password: state.password));
//       }
//     }
//   }

//   /// Executa a lógica de recuperação de secret.
//   Future<void> _onSecretRecoveryRequested(AuthSecretRecoveryRequested event, Emitter<AuthState> emit) async {
//     emit(AuthLoading(username: state.username, password: state.password));
//     try {
//       final recoveryData = RecoverSecretRequestModel(
//         username: "admin",
//         password: "password123",
//         code: event.recoveryCode,
//       );

//       final secret = await authService.recoverSecret(recoveryRequest: recoveryData);
//       await secretRepository.saveSecret(secret);

//       emit(const AuthReadyToLogin(username: 'admin', password: 'password123'));
//     } catch (e) {
//       emit(AuthFailure(e.toString(), username: state.username, password: state.password));
//       await Future.delayed(const Duration(seconds: 2));
//       emit(const AuthRequiresSecretRecovery());
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp/otp.dart';
import 'package:totp_authentication_app/auth/models/auth_model.dart';
import 'package:totp_authentication_app/auth/services/auth_services.dart';
import 'package:totp_authentication_app/project_configs/secret/secret_repository.dart';
import 'package:totp_authentication_app/auth/events/auth_events.dart';
import 'package:totp_authentication_app/auth/state/auth_state.dart';

/// Função auxiliar para gerar o código TOTP com base no secret.
String generateTOTP(String secret) {
  return OTP.generateTOTPCodeString(
    secret,
    DateTime.now().millisecondsSinceEpoch,
    interval: 30,
    algorithm: Algorithm.SHA1,
    isGoogle: true,
  );
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  final SecretRepository secretRepository;

  AuthBloc({required this.authService, required this.secretRepository}) : super(AuthInitial()) {
    on<AuthAppStarted>(_onAppStarted);
    on<AuthUsernameChanged>(_onUsernameChanged);
    on<AuthPasswordChanged>(_onPasswordChanged);
    on<AuthLoginSubmitted>(_onLoginSubmitted);
    on<AuthSecretRecoveryRequested>(_onSecretRecoveryRequested);
  }

  /// Garante que o app sempre comece na tela de login.
  Future<void> _onAppStarted(AuthAppStarted event, Emitter<AuthState> emit) async {
    emit(const AuthReadyToLogin(username: 'admin', password: 'password123'));
  }

  void _onUsernameChanged(AuthUsernameChanged event, Emitter<AuthState> emit) {
    emit(AuthReadyToLogin(username: event.username, password: state.password));
  }

  void _onPasswordChanged(AuthPasswordChanged event, Emitter<AuthState> emit) {
    emit(AuthReadyToLogin(username: state.username, password: event.password));
  }

  /// Executa a lógica de login com o mecanismo de autocorreção.
  Future<void> _onLoginSubmitted(AuthLoginSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading(username: state.username, password: state.password));
    try {
      final secret = await secretRepository.getSecret();

      if (secret == null || secret.isEmpty) {
        // ▼▼▼ A CORREÇÃO ESTÁ AQUI ▼▼▼
        // Apenas emitimos o estado de recuperação e paramos.
        // As duas linhas seguintes foram removidas.
        emit(const AuthRequiresSecretRecovery());
        return;
      }

      final totpCode = generateTOTP(secret);
      final loginData = LoginRequestModel(
        username: state.username,
        password: state.password,
        totpCode: totpCode,
      );
      
      await authService.login(loginRequest: loginData);
      emit(AuthSuccess());

    } catch (e) {
      if (e.toString().contains("Invalid TOTP code")) {
        emit(AuthFailure("Chave de acesso expirou. Por favor, recupere sua conta.", username: state.username, password: state.password));
        await secretRepository.deleteSecret();
        emit(const AuthRequiresSecretRecovery());
      } else {
        emit(AuthFailure(e.toString(), username: state.username, password: state.password));
      }
    }
  }

  /// Executa a lógica de recuperação de secret.
  Future<void> _onSecretRecoveryRequested(AuthSecretRecoveryRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading(username: state.username, password: state.password));
    try {
      final recoveryData = RecoverSecretRequestModel(
        username: "admin",
        password: "password123",
        code: event.recoveryCode,
      );

      final secret = await authService.recoverSecret(recoveryRequest: recoveryData);
      await secretRepository.saveSecret(secret);

      emit(const AuthReadyToLogin(username: 'admin', password: 'password123'));
    } catch (e) {
      emit(AuthFailure(e.toString(), username: state.username, password: state.password));
      await Future.delayed(const Duration(seconds: 2));
      emit(const AuthRequiresSecretRecovery());
    }
  }
}