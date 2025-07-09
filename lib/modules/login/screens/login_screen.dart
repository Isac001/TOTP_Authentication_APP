// Import necessary packages and custom widgets from the project.
import 'package:flutter/material.dart';
import 'package:totp_authentication_app/utils/constans_values.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';
import 'package:totp_authentication_app/widgets/basics/text_widget.dart';
import 'package:totp_authentication_app/widgets/buttons/elevated_button_widget.dart';
import 'package:totp_authentication_app/widgets/buttons/text_button_widget.dart';
import 'package:totp_authentication_app/widgets/fields/text_field_widget.dart';

/// A screen that provides a user interface for login.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

/// The state for the LoginScreen.
class _LoginScreenState extends State<LoginScreen> {
  // Controllers for the email and password text fields.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Cleans up the controllers when the widget is removed from the tree to prevent memory leaks.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColorsTheme.white,
      // Use SafeArea to prevent the UI from overlapping with system status bars.
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            // This structure ensures the content is scrollable on small screens
            // while also filling the viewport and allowing for vertical centering.
            constraints: BoxConstraints(
              minHeight: MediaQuery.sizeOf(context).height -
                  MediaQuery.paddingOf(context).top,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // CHANGE: A Spacer is added at the top to push the content towards the center.
                  const Spacer(),
                  _buildHeader(context),
                  _buildForm(context),
                  // This Spacer works with the one above to center the content.
                  const Spacer(),
                  _buildFooter(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the header section.
  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        // The image will now use fitWidth to fill the available width.
        Image.asset(
          'lib/assets/images/login_image.png',
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        // The main, large space between the image and the form.
        SizedBox(height: MediaQuery.of(context).size.height * 0.06),
      ],
    );
  }

  /// Builds the form section, now narrower and with smaller internal spacing.
  Widget _buildForm(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    // Increased horizontal padding to center and narrow the form.
    return Padding(
      padding: const EdgeInsets.all(kPaddingMedium),
      child: Column(
        children: [
          _emailField(),
          // SMALL space between fields to group them visually.
          SizedBox(height: screenHeight * 0.02),
          _passwordField(),
          // SMALL space between the password field and the button.
          SizedBox(height: screenHeight * 0.025),
          _loginButton(),
        ],
      ),
    );
  }

  /// Builds the footer section of the screen.
  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      child: _forgotPasswordButton(),
    );
  }

  // --- Individual Field/Button Widgets (no changes) ---

  /// Builds the password input field.
  Widget _passwordField() {
    return TextFieldWidget(
      controller: _passwordController,
      textLabel: 'Senha', // "Password"
      obscure: true,
      isBorderless: true,
    );
  }

  /// Builds the email input field.
  Widget _emailField() {
    return TextFieldWidget(
      controller: _emailController,
      textLabel: 'E-mail', // "E-mail"
      keyboardType: TextInputType.emailAddress,
      isBorderless: true,
    );
  }

  /// Builds the primary login button.
  Widget _loginButton() {
    return ElevatedButtonWidget(
      text: TextWidget(
        'Entrar', // "Login"
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: ProjectColorsTheme.white),
      ),
      onTap: () {},
      buttonColor: ProjectColorsTheme.primaryColor,
      onButtonColor: ProjectColorsTheme.white,
      borderRadius: BorderRadius.circular(12),
      buttonHeight: 55,
    );
  }

  /// Builds the 'Forgot Password' text button.
  Widget _forgotPasswordButton() {
    return TextButtonWidget(
      text: 'Esqueci a senha', // "Forgot password"
      fontSize: kBodyFontSizeBig,
      textColor: ProjectColorsTheme.primaryColor,
      onTap: () {},
    );
  }
}