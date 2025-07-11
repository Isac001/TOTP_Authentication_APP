import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totp_authentication_app/auth/bloc_state_controller/auth_bloc.dart';
import 'package:totp_authentication_app/auth/bloc_state_controller/auth_state.dart';

// A widget that wraps the app and directs users based on auth state.
class AuthWrapper extends StatelessWidget {
  // Constant constructor for the widget.
  const AuthWrapper({super.key});

  // Describes the part of the user interface represented by this widget.
  @override
  // The build method returns the widget tree.
  Widget build(BuildContext context) {
    // Listens to state changes in AuthBloc to perform actions.
    return BlocListener<AuthBloc, AuthState>(
      // Controls when the listener should be triggered.
      listenWhen: (previous, current) {
        // Returns true only for states relevant to navigation.
        return current is AuthReadyToLogin ||
               current is AuthRequiresSecretRecovery ||
               current is AuthSuccess;
      },
      // The function that is called when a relevant state change occurs.
      listener: (context, state) {
        // Checks if the state indicates the user should go to the login screen.
        if (state is AuthReadyToLogin) {
          // Replaces the current screen with the login screen.
          Navigator.pushReplacementNamed(context, '/login');
        // Checks if the state indicates secret recovery is required.
        } else if (state is AuthRequiresSecretRecovery) {
          // Replaces the current screen with the recovery screen.
          Navigator.pushReplacementNamed(context, '/recovery');
        // Checks if the state indicates a successful login.
        } else if (state is AuthSuccess) {
          // Replaces the current screen with the home screen.
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      // The UI to display while waiting for a state change.
      child: const Scaffold(
        // The body of the Scaffold.
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}