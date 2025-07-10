// // // lib/auth/bloc/auth_state.dart

// // import 'package:equatable/equatable.dart';

// // // A classe base que já implementa o 'props' padrão.
// // abstract class AuthState extends Equatable {
// //   const AuthState();
// //   @override
// //   List<Object?> get props => [];
// // }

// // // ▼▼▼ A CORREÇÃO ESTÁ AQUI ▼▼▼
// // // Agora estende AuthState, herdando a implementação de 'props'.
// // class AuthInitial extends AuthState {}

// // // As outras classes já estavam corretas, estendendo AuthState.
// // class AuthLoading extends AuthState {}

// // class AuthReadyToLogin extends AuthState {}

// // class AuthRequiresSecretRecovery extends AuthState {}

// // class AuthSuccess extends AuthState {}

// // // Esta classe está correta pois, além de estender AuthState,
// // // ela tem sua própria propriedade e a adiciona à lista 'props'.
// // class AuthFailure extends AuthState {
// //   final String message;
// //   const AuthFailure(this.message);
// //   @override
// //   List<Object?> get props => [message];
// // }


// import 'package:equatable/equatable.dart';

// // A classe base agora carrega os dados do formulário
// abstract class AuthState extends Equatable {
//   final String username;
//   final String password;

//   // Um getter útil para validar o formulário em tempo real na UI
//   bool get isFormValid => username == 'admin' && password == 'password123';

//   const AuthState({this.username = '', this.password = ''});

//   @override
//   List<Object?> get props => [username, password];
// }

// class AuthInitial extends AuthState {}

// // O estado de loading agora também mantém os dados do formulário
// class AuthLoading extends AuthState {
//   const AuthLoading({required super.username, required super.password});
// }

// // Este estado representa o formulário pronto para interação
// class AuthReadyToLogin extends AuthState {
//   const AuthReadyToLogin({required super.username, required super.password});
// }

// class AuthRequiresSecretRecovery extends AuthState {}

// class AuthSuccess extends AuthState {}

// class AuthFailure extends AuthState {
//   final String message;
//   const AuthFailure(this.message, {required super.username, required super.password});
//   @override
//   List<Object?> get props => [message, username, password];
// }


import 'package:equatable/equatable.dart';

// A classe base agora carrega os dados do formulário
abstract class AuthState extends Equatable {
  final String username;
  final String password;

  // Validação simples para o formulário (pode ser melhorada)
  bool get isFormValid => username.isNotEmpty && password.isNotEmpty;

  const AuthState({this.username = '', this.password = ''});

  @override
  List<Object?> get props => [username, password];
}

class AuthInitial extends AuthState {}

// O estado de loading agora também mantém os dados do formulário
class AuthLoading extends AuthState {
  const AuthLoading({required super.username, required super.password});
}

// Este estado representa o formulário pronto para interação
class AuthReadyToLogin extends AuthState {
  const AuthReadyToLogin({required super.username, required super.password});
}

// ==================================================
// CORREÇÃO: Este estado é um comando de navegação e não precisa dos dados do formulário.
// ==================================================
class AuthRequiresSecretRecovery extends AuthState {
  // Removemos o construtor com username e password.
  const AuthRequiresSecretRecovery();
}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message, {required super.username, required super.password});
  @override
  List<Object?> get props => [message, username, password];
}