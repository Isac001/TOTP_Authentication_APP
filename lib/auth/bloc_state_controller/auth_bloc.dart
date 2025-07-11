import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totp_authentication_app/auth/bloc_state_controller/totp_code_generator.dart';
import 'package:totp_authentication_app/auth/models/auth_model.dart';
import 'package:totp_authentication_app/auth/services/auth_services.dart';
import 'package:totp_authentication_app/auth/bloc_state_controller/auth_events.dart';
import 'package:totp_authentication_app/auth/bloc_state_controller/auth_state.dart';
import 'package:totp_authentication_app/project_configs/storage_secret/secret_storage_repository.dart';

// Manages the authentication state and logic of the application.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // A dependency for the authentication service.
  final AuthService authService;
  // A dependency for the secret storage repository.
  final SecretRepository secretRepository;

  // Constructor for AuthBloc, requiring services and repositories.
  AuthBloc({required this.authService, required this.secretRepository})
      // Initializes the BLoC with the AuthInitial state.
      : super(AuthInitial()) {
    // Registers a handler for the AuthAppStarted event.
    on<AuthAppStarted>(_onAppStarted);
    // Registers a handler for the AuthUsernameChanged event.
    on<AuthUsernameChanged>(_onUsernameChanged);
    // Registers a handler for the AuthPasswordChanged event.
    on<AuthPasswordChanged>(_onPasswordChanged);
    // Registers a handler for the AuthLoginSubmitted event.
    on<AuthLoginSubmitted>(_onLoginSubmitted);
    // Registers a handler for the AuthSecretRecoveryRequested event.
    on<AuthSecretRecoveryRequested>(_onSecretRecoveryRequested);
    // Registers a handler for the AuthRecoveryCodeChanged event.
    on<AuthRecoveryCodeChanged>(_onRecoveryCodeChanged);
    // Registers a handler for the AuthStateReset event.
    on<AuthStateReset>(_onStateReset);
  }

  // Handles the app start-up event.
  Future<void> _onAppStarted(
      AuthAppStarted event, Emitter<AuthState> emit) async {
    // Emits the initial state for the login screen.
    emit(const AuthReadyToLogin(username: '', password: ''));
  }

  // Handles changes to the username input field.
  void _onUsernameChanged(AuthUsernameChanged event, Emitter<AuthState> emit) {
    // Emits a new state with the updated username.
    emit(AuthReadyToLogin(
        // Sets the new username from the event.
        username: event.username,
        // Keeps the existing password from the current state.
        password: state.password,
        // Keeps the existing recovery code from the current state.
        recoveryCode: state.recoveryCode));
  }

  // Handles changes to the password input field.
  void _onPasswordChanged(AuthPasswordChanged event, Emitter<AuthState> emit) {
    // Emits a new state with the updated password.
    emit(AuthReadyToLogin(
        // Keeps the existing username from the current state.
        username: state.username,
        // Sets the new password from the event.
        password: event.password,
        // Keeps the existing recovery code from the current state.
        recoveryCode: state.recoveryCode));
  }

  // Handles changes to the recovery code input field.
  void _onRecoveryCodeChanged(
      AuthRecoveryCodeChanged event, Emitter<AuthState> emit) {
    // Emits a state indicating the recovery screen is ready with new data.
    emit(AuthRecoveryReady(
        // Keeps the existing username from the current state.
        username: state.username,
        // Keeps the existing password from the current state.
        password: state.password,
        // Sets the new recovery code from the event.
        recoveryCode: event.code));
  }

  // Handles the event to reset the state.
  void _onStateReset(AuthStateReset event, Emitter<AuthState> emit) {
    // Emits the ready-to-login state to reset the login UI.
    emit(AuthReadyToLogin(
      // Keeps the existing username from the current state.
      username: state.username,
      // Keeps the existing password from the current state.
      password: state.password,
    ));
  }

  // Handles the login submission event.
  Future<void> _onLoginSubmitted(
      AuthLoginSubmitted event, Emitter<AuthState> emit) async {
    // Emits a loading state to indicate an ongoing process.
    emit(AuthLoading(username: state.username, password: state.password));
    // Begins a try-catch block for error handling.
    try {
      // Asynchronously gets the secret from the repository.
      final secret = await secretRepository.getSecret();

      // Checks if the secret is null or empty.
      if (secret == null || secret.isEmpty) {
        // Emits a state to signal that secret recovery is needed.
        emit(const AuthRequiresSecretRecovery());
        // Exits the method early.
        return;
      }

      // Generates a new TOTP code with the secret.
      final totpCode = generateTOTP(secret);
      // Creates the login request data model.
      final loginData = LoginRequestModel(
        // Sets the username from the current state.
        username: state.username,
        // Sets the password from the current state.
        password: state.password,
        // Sets the generated TOTP code.
        totpCode: totpCode,
      );

      // Attempts to log in by calling the auth service.
      await authService.login(loginRequest: loginData);
      // Emits a success state upon successful login.
      emit(AuthSuccess());
    } catch (e) {
      // Converts the error object to a lowercase string for case-insensitive matching.
      final rawError = e.toString().toLowerCase();

      // Checks if the error message contains "invalid credentials".
      if (rawError.contains("invalid credentials")) {
        // Emits a specific failure state for login errors.
        emit(AuthLoginFailure("Credenciais inválidas",
            username: state.username, password: state.password));
        // Emits a ready state to allow the user to try again.
        emit(AuthReadyToLogin(
            username: state.username, password: state.password));

      } else if (rawError.contains("invalid totp code")) {
        // Deletes the invalid secret from storage.
        await secretRepository.deleteSecret();
        // Emits a state to navigate the user to the recovery screen.
        emit(const AuthRequiresSecretRecovery());

      } else {
        // Emits a specific failure state for generic login errors.
        emit(AuthLoginFailure("Ocorreu um erro inesperado. Tente novamente.",
            username: state.username, password: state.password));
        // Emits a ready state to allow the user to try again.
        emit(AuthReadyToLogin(
            username: state.username, password: state.password));
      }
    }
  }

  // Handles the secret recovery request event.
  Future<void> _onSecretRecoveryRequested(
      AuthSecretRecoveryRequested event, Emitter<AuthState> emit) async {
    // Emits a loading state to indicate an ongoing process.
    emit(AuthLoading(username: state.username, password: state.password));
    // Begins a try-catch block for error handling.
    try {
      // Creates the recovery request data model.
      final recoveryData = RecoverSecretRequestModel(
        // Uses a hardcoded username for the recovery process.
        username: "admin",
        // Uses a hardcoded password for the recovery process.
        password: "password123",
        // Sets the recovery code from the event.
        code: event.recoveryCode,
      );

      // Attempts to recover the secret by calling the auth service.
      final secret =
          await authService.recoverSecret(recoveryRequest: recoveryData);
      // Saves the newly recovered secret to secure storage.
      await secretRepository.saveSecret(secret);

      // Emits a ready-to-login state to redirect the user.
      emit(const AuthReadyToLogin(username: 'admin', password: 'password123'));
    } catch (e) {
      // Emits a specific failure state for recovery errors.
      emit(AuthRecoveryFailure("Código de recuperação inválido ou expirado.",
          username: state.username,
          password: state.password,
          recoveryCode: state.recoveryCode));

      // Emits a recovery-ready state to reset the UI for another attempt.
      emit(AuthRecoveryReady(
          username: state.username,
          password: state.password,
          recoveryCode: state.recoveryCode));
    }
  }
}