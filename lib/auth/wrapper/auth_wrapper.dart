import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totp_authentication_app/auth/bloc/auth_bloc.dart';
import 'package:totp_authentication_app/auth/state/auth_state.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthReadyToLogin) {
          Navigator.pushReplacementNamed(context, '/login');
        } else if (state is AuthRequiresSecretRecovery) {
          Navigator.pushReplacementNamed(context, '/recovery');
        } else if (state is AuthSuccess) {
          // Caso o usuário já estivesse logado (não se aplica neste teste, mas é bom ter)
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}