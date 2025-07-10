// // Imports necessários para o BLoC
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:totp_authentication_app/auth/state_controllers/auth_bloc.dart';
// import 'package:totp_authentication_app/auth/state_controllers/auth_events.dart';
// import 'package:totp_authentication_app/auth/state_controllers/auth_state.dart';

// // Imports dos seus widgets e configurações
// import 'package:totp_authentication_app/utils/constans_values.dart';
// import 'package:totp_authentication_app/utils/project_colors_theme.dart';
// import 'package:totp_authentication_app/widgets/basics/text_widget.dart';
// import 'package:totp_authentication_app/widgets/buttons/elevated_button_widget.dart';
// import 'package:totp_authentication_app/widgets/fields/text_field_widget.dart';
// import 'package:totp_authentication_app/widgets/buttons/text_button_widget.dart';


// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   // Pré-preenchemos os controllers para facilitar os testes, conforme a documentação
//   final _usernameController = TextEditingController(text: 'admin');
//   final _passwordController = TextEditingController(text: 'password123');

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message), backgroundColor: Colors.red),
//           );
//         } else if (state is AuthSuccess) {
//           Navigator.of(context).pushReplacementNamed('/home');
//         }
//       },
//       builder: (context, state) {
//         final isLoading = state is AuthLoading;

//         return Scaffold(
//           backgroundColor: ProjectColorsTheme.white,
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   // ==================================================
//                   // A CORREÇÃO ESTÁ NA LINHA ABAIXO:
//                   // Trocamos .sizeOf(context) por .size, que é a propriedade correta.
//                   // ==================================================
//                   minHeight: MediaQuery.of(context).size.height -
//                       MediaQuery.of(context).padding.top,
//                 ),
//                 child: IntrinsicHeight(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const Spacer(),
//                       _buildHeader(context),
//                       _buildForm(context, isLoading),
//                       const Spacer(),
//                       _buildFooter(context),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Column(
//       children: [
//         Image.asset(
//           'lib/assets/images/login_image.png',
//           width: double.infinity,
//           fit: BoxFit.fitWidth,
//         ),
//         SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//       ],
//     );
//   }

//   Widget _buildForm(BuildContext context, bool isLoading) {
//     return Padding(
//       padding: const EdgeInsets.all(kPaddingMedium),
//       child: Column(
//         children: [
//           _usernameField(),
//           SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//           _passwordField(),
//           SizedBox(height: MediaQuery.of(context).size.height * 0.025),
//           _loginButton(isLoading),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildFooter(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
//       child: _forgotPasswordButton(),
//     );
//   }

//   Widget _passwordField() {
//     return TextFieldWidget(
//       controller: _passwordController,
//       textLabel: 'Senha',
//       obscure: true,
//       isBorderless: true,
//     );
//   }

//   Widget _usernameField() {
//     return TextFieldWidget(
//       controller: _usernameController,
//       textLabel: 'Nome de usuário',
//       keyboardType: TextInputType.text,
//       isBorderless: true,
//     );
//   }

//   Widget _loginButton(bool isLoading) {
//     return ElevatedButtonWidget(
//       text: isLoading
//           ? const CircularProgressIndicator(color: Colors.white)
//           : TextWidget(
//               'Entrar',
//               style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                   color: ProjectColorsTheme.white),
//             ),
//       isEnabled: !isLoading,
//       onTap: () {
//         if (!isLoading) {
//           context.read<AuthBloc>().add(
//                 AuthLoginRequested(
//                   username: _usernameController.text,
//                   password: _passwordController.text,
//                 ),
//               );
//         }
//       },
//       buttonColor: ProjectColorsTheme.primaryColor,
//       onButtonColor: ProjectColorsTheme.white,
//       borderRadius: BorderRadius.circular(12),
//       buttonHeight: 55,
//     );
//   }

//   Widget _forgotPasswordButton() {
//     return TextButtonWidget(
//       text: 'Esqueci a senha',
//       fontSize: kBodyFontSizeBig,
//       textColor: ProjectColorsTheme.primaryColor,
//       onTap: () {
//         // Futuramente, pode disparar um evento para recuperação de senha
//       },
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // Imports da sua arquitetura BLoC
// import 'package:totp_authentication_app/auth/state_controllers/auth_bloc.dart';
// import 'package:totp_authentication_app/auth/state_controllers/auth_events.dart';
// import 'package:totp_authentication_app/auth/state_controllers/auth_state.dart';

// // Imports dos seus widgets e configurações de UI
// import 'package:totp_authentication_app/utils/constans_values.dart';
// import 'package:totp_authentication_app/utils/project_colors_theme.dart';
// import 'package:totp_authentication_app/widgets/basics/text_widget.dart';
// import 'package:totp_authentication_app/widgets/buttons/elevated_button_widget.dart';
// import 'package:totp_authentication_app/widgets/fields/text_field_widget.dart';
// import 'package:totp_authentication_app/widgets/buttons/text_button_widget.dart';


// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   // Os controllers ainda são úteis para controlar o foco e o cursor do TextField.
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Para garantir que os campos reflitam o estado do BLoC ao construir a tela.
//     final initialState = context.read<AuthBloc>().state;
//     _usernameController.text = initialState.username;
//     _passwordController.text = initialState.password;
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // O BlocListener é ideal para "efeitos colaterais" como navegação e SnackBars,
//     // pois não reconstrói a UI.
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         // Sincroniza o controller se o estado no BLoC mudar por outra razão
//         if (state.username != _usernameController.text) {
//           _usernameController.text = state.username;
//         }
//         if (state.password != _passwordController.text) {
//           _passwordController.text = state.password;
//         }

//         // Mostra o erro em caso de falha
//         if (state is AuthFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message), backgroundColor: Colors.red),
//           );
//         } 
//         // Navega para a Home em caso de sucesso
//         else if (state is AuthSuccess) {
//           Navigator.of(context).pushReplacementNamed('/home');
//         }
//       },
//       child: Scaffold(
//         backgroundColor: ProjectColorsTheme.white,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 minHeight: MediaQuery.of(context).size.height -
//                     MediaQuery.of(context).padding.top,
//               ),
//               child: IntrinsicHeight(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     const Spacer(),
//                     _buildHeader(context),
//                     _buildForm(context),
//                     const Spacer(),
//                     _buildFooter(context),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Column(
//       children: [
//         Image.asset(
//           'lib/assets/images/login_image.png',
//           width: double.infinity,
//           fit: BoxFit.fitWidth,
//         ),
//         SizedBox(height: MediaQuery.of(context).size.height * 0.06),
//       ],
//     );
//   }

//   Widget _buildForm(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(kPaddingMedium),
//       child: Column(
//         children: [
//           _usernameField(),
//           SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//           _passwordField(),
//           SizedBox(height: MediaQuery.of(context).size.height * 0.025),
//           _loginButton(),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildFooter(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
//       child: _forgotPasswordButton(),
//     );
//   }

//   Widget _passwordField() {
//     return TextFieldWidget(
//       controller: _passwordController,
//       textLabel: 'Senha',
//       obscure: true,
//       isBorderless: true,
//       onChanged: (password) {
//         // Notifica o BLoC sobre a mudança no campo de senha
//         context.read<AuthBloc>().add(AuthPasswordChanged(password));
//       },
//     );
//   }

//   Widget _usernameField() {
//     return TextFieldWidget(
//       controller: _usernameController,
//       textLabel: 'Nome de usuário',
//       keyboardType: TextInputType.text,
//       isBorderless: true,
//       onChanged: (username) {
//         // Notifica o BLoC sobre a mudança no campo de usuário
//         context.read<AuthBloc>().add(AuthUsernameChanged(username));
//       },
//     );
//   }

//   Widget _loginButton() {
//     // O BlocBuilder reconstrói apenas o botão quando o estado muda,
//     // o que é muito eficiente.
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         final isLoading = state is AuthLoading;
//         // A validação para habilitar o botão vem diretamente do estado do BLoC
//         final isEnabled = state.isFormValid && !isLoading;

//         return ElevatedButtonWidget(
//           text: isLoading
//               ? const CircularProgressIndicator(color: Colors.white)
//               : TextWidget(
//                   'Entrar',
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                       color: ProjectColorsTheme.white),
//                 ),
//           isEnabled: isEnabled,
//           onTap: isEnabled
//               ? () {
//                   // Dispara o evento de submissão, sem precisar passar dados
//                   context.read<AuthBloc>().add(AuthLoginSubmitted());
//                 }
//               : null, // null desabilita o botão
//       buttonColor: ProjectColorsTheme.primaryColor,
//       onButtonColor: ProjectColorsTheme.white,
//       borderRadius: BorderRadius.circular(12),
//       buttonHeight: 55,
//         );
//       },
//     );
//   }

//   Widget _forgotPasswordButton() {
//     return TextButtonWidget(
//       text: 'Esqueci a senha',
//       fontSize: kBodyFontSizeBig,
//       textColor: ProjectColorsTheme.primaryColor,
//       onTap: () {
//         // Ação futura
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totp_authentication_app/auth/bloc/auth_bloc.dart';
import 'package:totp_authentication_app/auth/events/auth_events.dart';
import 'package:totp_authentication_app/auth/state/auth_state.dart';
import 'package:totp_authentication_app/utils/constans_values.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';
import 'package:totp_authentication_app/widgets/basics/text_widget.dart';
import 'package:totp_authentication_app/widgets/buttons/elevated_button_widget.dart';
import 'package:totp_authentication_app/widgets/buttons/text_button_widget.dart';
import 'package:totp_authentication_app/widgets/fields/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final initialState = context.read<AuthBloc>().state;
    _usernameController.text = initialState.username;
    _passwordController.text = initialState.password;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is AuthSuccess) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (state is AuthRequiresSecretRecovery) {
          // CHECKPOINT FINAL: Este print confirma se o listener está sendo acionado.
          print("🚨 LISTENER: Estado de recuperação detectado! Tentando navegar para /recovery...");
          Navigator.of(context).pushNamed('/recovery');
        }
      },
      child: Scaffold(
        backgroundColor: ProjectColorsTheme.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    _buildHeader(context),
                    _buildForm(context),
                    const Spacer(),
                    _buildFooter(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'lib/assets/images/login_image.png',
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.06),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPaddingMedium),
      child: Column(
        children: [
          _usernameField(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          _passwordField(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          _loginButton(),
        ],
      ),
    );
  }
  
  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      child: _forgotPasswordButton(),
    );
  }

  Widget _passwordField() {
    return TextFieldWidget(
      controller: _passwordController,
      textLabel: 'Senha',
      obscure: true,
      isBorderless: true,
      onChanged: (password) {
        context.read<AuthBloc>().add(AuthPasswordChanged(password));
      },
    );
  }

  Widget _usernameField() {
    return TextFieldWidget(
      controller: _usernameController,
      textLabel: 'Nome de usuário',
      keyboardType: TextInputType.text,
      isBorderless: true,
      onChanged: (username) {
        context.read<AuthBloc>().add(AuthUsernameChanged(username));
      },
    );
  }

  Widget _loginButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      // O 'buildWhen' é uma otimização: só reconstrói o botão se o estado for
      // de loading ou pronto para login, evitando rebuilds desnecessários.
      buildWhen: (previous, current) =>
          current is AuthLoading || current is AuthReadyToLogin,
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        // Validação simples para o botão.
        final isEnabled = !isLoading && 
                          _usernameController.text.isNotEmpty && 
                          _passwordController.text.isNotEmpty;

        return ElevatedButtonWidget(
          text: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : TextWidget(
                  'Entrar',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: ProjectColorsTheme.white),
                ),
          isEnabled: isEnabled,
          onTap: isEnabled
              ? () {
                  context.read<AuthBloc>().add(AuthLoginSubmitted());
                }
              : null,
          buttonColor: ProjectColorsTheme.primaryColor,
          onButtonColor: ProjectColorsTheme.white,
          borderRadius: BorderRadius.circular(12),
          buttonHeight: 55,
        );
      },
    );
  }

  Widget _forgotPasswordButton() {
    return TextButtonWidget(
      text: 'Esqueci a senha',
      fontSize: kBodyFontSizeBig,
      textColor: ProjectColorsTheme.primaryColor,
      onTap: () {},
    );
  }
}