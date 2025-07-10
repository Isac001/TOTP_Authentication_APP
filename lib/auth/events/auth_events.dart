// import 'package:equatable/equatable.dart';

// abstract class AuthEvent extends Equatable {
//   const AuthEvent();
//   @override
//   List<Object> get props => [];
// }

// // Evento disparado no início do app para verificar o estado inicial.
// class AuthAppStarted extends AuthEvent {}

// // Evento disparado quando o usuário clica no botão "Login".
// class AuthLoginRequested extends AuthEvent {
//   final String username;
//   final String password;
//   const AuthLoginRequested({required this.username, required this.password});
// }

// // Evento disparado quando o usuário clica no botão "Recuperar Secret".
// class AuthSecretRecoveryRequested extends AuthEvent {
//   final String recoveryCode;
//   const AuthSecretRecoveryRequested({required this.recoveryCode});
// }

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class AuthAppStarted extends AuthEvent {}

// Novo evento: notifica que o campo de usuário mudou
class AuthUsernameChanged extends AuthEvent {
  final String username;
  const AuthUsernameChanged(this.username);
  @override
  List<Object> get props => [username];
}

// Novo evento: notifica que o campo de senha mudou
class AuthPasswordChanged extends AuthEvent {
  final String password;
  const AuthPasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

// Evento de submissão, agora mais simples
class AuthLoginSubmitted extends AuthEvent {}

// O evento de recuperação não muda
class AuthSecretRecoveryRequested extends AuthEvent {
  final String recoveryCode;
  const AuthSecretRecoveryRequested({required this.recoveryCode});
}