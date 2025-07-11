import 'package:equatable/equatable.dart';

// Defines the base abstract class for all authentication events.
abstract class AuthEvent extends Equatable {
  // Constant constructor for the base event.
  const AuthEvent();
  // Overrides the props getter for equatable comparison.
  @override
  // Returns an empty list as the base event has no properties.
  List<Object> get props => [];
}

// Event triggered when the application starts.
class AuthAppStarted extends AuthEvent {}

// Event triggered when the username input changes.
class AuthUsernameChanged extends AuthEvent {
  // Final property to hold the username string.
  final String username;
  // Constant constructor requiring a username.
  const AuthUsernameChanged(this.username);
  // Overrides props to include the username for comparison.
  @override
  // Returns a list containing the username.
  List<Object> get props => [username];
}

// Event triggered when the password input changes.
class AuthPasswordChanged extends AuthEvent {
  // Final property to hold the password string.
  final String password;
  // Constant constructor requiring a password.
  const AuthPasswordChanged(this.password);
  // Overrides props to include the password for comparison.
  @override
  // Returns a list containing the password.
  List<Object> get props => [password];
}

// Event triggered when the login form is submitted.
class AuthLoginSubmitted extends AuthEvent {}

// Event triggered when the recovery code input changes.
class AuthRecoveryCodeChanged extends AuthEvent {
  // Final property to hold the recovery code string.
  final String code;
  // Constant constructor requiring a recovery code.
  const AuthRecoveryCodeChanged(this.code);
  // Overrides props to include the code for comparison.
  @override
  // Returns a list containing the code.
  List<Object> get props => [code];
}


// Event triggered when the secret recovery is requested.
class AuthSecretRecoveryRequested extends AuthEvent {
  // Final property to hold the recovery code string.
  final String recoveryCode;
  // Constant constructor requiring a named recoveryCode.
  const AuthSecretRecoveryRequested({required this.recoveryCode});
}

// Event triggered to reset the authentication state.
class AuthStateReset extends AuthEvent {}