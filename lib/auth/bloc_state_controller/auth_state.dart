import 'package:equatable/equatable.dart';

// Defines the base abstract class for all authentication states.
abstract class AuthState extends Equatable {
  // Final property to hold the username.
  final String username;
  // Final property to hold the password.
  final String password;
  // Final property to hold the recovery code.
  final String recoveryCode;

  // A getter to check if the login form is valid.
  bool get isLoginFormValid => username.isNotEmpty && password.isNotEmpty;

  // A getter to check if the recovery code is valid.
  bool get isRecoveryCodeValid => recoveryCode.length == 6;

  // Constant constructor for the base state with default values.
  const AuthState({
    // Sets the default username to an empty string.
    this.username = '',
    // Sets the default password to an empty string.
    this.password = '',
    // Sets the default recovery code to an empty string.
    this.recoveryCode = '',
  });

  @override
  // Returns a list of properties to be used in the equality comparison.
  List<Object?> get props => [username, password, recoveryCode];
}

// Represents the initial state of the BLoC.
class AuthInitial extends AuthState {}

// Represents a loading state during an asynchronous operation.
class AuthLoading extends AuthState {
  // Constant constructor passing properties to the base class.
  const AuthLoading({
    required super.username,
    required super.password,
    super.recoveryCode,
  });
}

// Represents the state where the login form is ready for user input.
class AuthReadyToLogin extends AuthState {
  // Constant constructor passing properties to the base class.
  const AuthReadyToLogin({
    required super.username,
    required super.password,
    super.recoveryCode,
  });
}

// Represents the state where secret recovery is required.
class AuthRequiresSecretRecovery extends AuthState {
  // Constant constructor for this specific state.
  const AuthRequiresSecretRecovery();
}

// Represents a successful authentication state.
class AuthSuccess extends AuthState {}

// Represents the state where the recovery screen is ready for input.
class AuthRecoveryReady extends AuthState {
  // Constant constructor passing properties to the base class.
  const AuthRecoveryReady({
    required super.username,
    required super.password,
    required super.recoveryCode,
  });
}

// Represents a failure that occurred specifically on the login screen.
class AuthLoginFailure extends AuthState {
  // Final property to hold the error message.
  final String message;

  // Constant constructor requiring a message and other properties.
  const AuthLoginFailure(
    this.message, {
    required super.username,
    required super.password,
  });

  @override
  // Returns a list of all properties including the message.
  List<Object?> get props => [message, username, password];
}

// Represents a failure that occurred specifically on the recovery screen.
class AuthRecoveryFailure extends AuthState {
  // Final property to hold the error message.
  final String message;

  // Constant constructor requiring a message and other properties.
  const AuthRecoveryFailure(
    this.message, {
    required super.username,
    required super.password,
    required super.recoveryCode,
  });
  @override
  // Returns a list of all properties including the message.
  List<Object?> get props => [message, username, password, recoveryCode];
}
