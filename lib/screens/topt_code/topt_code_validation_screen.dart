// Imports necessários, incluindo os do BLoC
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totp_authentication_app/auth/bloc/auth_bloc.dart';
import 'package:totp_authentication_app/auth/events/auth_events.dart';
import 'package:totp_authentication_app/auth/state/auth_state.dart';

// Imports dos seus widgets e configurações
import 'package:totp_authentication_app/utils/constans_values.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';
import 'package:totp_authentication_app/widgets/basics/icon_widget.dart';
import 'package:totp_authentication_app/widgets/basics/text_widget.dart';
import 'package:totp_authentication_app/widgets/buttons/elevated_button_widget.dart';
import 'package:totp_authentication_app/widgets/buttons/icon_button_widget.dart';
import 'package:totp_authentication_app/widgets/buttons/text_button_widget.dart';
import 'package:totp_authentication_app/widgets/fields/code_totp_field_widget.dart';

/// Esta tela agora funciona como a página de Recuperação de Secret.
class TOPTCodeValidationScreen extends StatefulWidget {
  const TOPTCodeValidationScreen({super.key});

  @override
  State<TOPTCodeValidationScreen> createState() =>
      _TOPTCodeValidationScreenState();
}

class _TOPTCodeValidationScreenState extends State<TOPTCodeValidationScreen> {
  final _codeController = TextEditingController();

  // A lógica de _isButtonEnabled e _onCodeChanged foi removida,
  // pois o BLoC agora gerencia o estado do botão.

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Envolvemos o Scaffold com BlocConsumer para ouvir e reconstruir a UI
    return BlocConsumer<AuthBloc, AuthState>(
      // 2. O 'listener' lida com navegação e SnackBars
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is AuthReadyToLogin) {
          // Sucesso! O secret foi recuperado.
          // O AuthWrapper irá garantir que o app vá para a tela de login.
          // Se esta tela foi chamada por cima, podemos simplesmente fechar.
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          } else {
            // Caso contrário, garantimos a navegação para o login.
            Navigator.of(context).pushReplacementNamed('/login');
          }
        }
      },
      // 3. O 'builder' reconstrói a UI com base no estado atual
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: ProjectColorsTheme.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: _exitButton(),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                _buildHeader(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                _buildCodeField(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                // 4. Passamos o estado de 'isLoading' para o botão
                _buildConfirmButton(isLoading),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                _buildResendCodeButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: kPaddingSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            'Recuperação de Secret', // Título mais claro
            style: TextStyle(
              fontSize: kTitleFontSizeBig,
              fontWeight: FontWeight.bold,
              color: ProjectColorsTheme.textPrimary,
            ),
          ),
          TextWidget(
            'Insira o código de recuperação fornecido para configurar sua conta.', // Subtítulo mais claro
            style: TextStyle(
              fontSize: kBodyFontSizeBig,
              color: ProjectColorsTheme.darkGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeField() {
    // O onCompleted pode ser útil para submeter automaticamente
    return CodeTOTPFieldWidget(
      controller: _codeController,
      numberOfFields: 6,
      onCompleted: (code) {
        // Quando o usuário preenche tudo, disparamos o evento
        context.read<AuthBloc>().add(
              AuthSecretRecoveryRequested(recoveryCode: code),
            );
      },
    );
  }

  /// 5. O botão agora é controlado pelo BLoC
  Widget _buildConfirmButton(bool isLoading) {
    return ElevatedButtonWidget(
      text: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : TextWidget(
              'Recuperar', // Texto do botão atualizado
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: ProjectColorsTheme.white),
            ),
      isEnabled: !isLoading,
      onTap: () {
        if (!isLoading) {
          // Dispara o evento para o BLoC com o código do controller
          context.read<AuthBloc>().add(
                AuthSecretRecoveryRequested(recoveryCode: _codeController.text),
              );
        }
      },
      buttonColor: ProjectColorsTheme.primaryColor,
      onButtonColor: ProjectColorsTheme.white,
      borderRadius: BorderRadius.circular(12),
      buttonHeight: MediaQuery.of(context).size.height * 0.06,
    );
  }

  Widget _buildResendCodeButton() {
    // Este botão não tem ação neste desafio, mas a estrutura está aqui
    return Center(
      child: TextButtonWidget(
        icon: IconWidget(
          Icons.chat_bubble_outline_outlined,
          color: ProjectColorsTheme.primaryColor,
          size: MediaQuery.of(context).size.height * 0.025,
        ),
        text: 'Não recebi o código',
        fontSize: kBodyFontSizeBig,
        textColor: ProjectColorsTheme.darkGrey,
        onTap: () {
          // Em um app real, poderia disparar outro evento
        },
      ),
    );
  }

  Widget _exitButton() {
    return IconButtonWidget(
      icon: Icons.arrow_back_ios,
      size: MediaQuery.of(context).size.height * 0.025,
      color: ProjectColorsTheme.primaryColor,
      onTap: () {
        // Ação de voltar padrão
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}