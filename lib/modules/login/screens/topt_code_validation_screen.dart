// Import necessary packages and custom widgets from the project.
import 'package:flutter/material.dart';
import 'package:totp_authentication_app/utils/constans_values.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';
import 'package:totp_authentication_app/widgets/basics/icon_widget.dart';
import 'package:totp_authentication_app/widgets/basics/text_widget.dart';
import 'package:totp_authentication_app/widgets/buttons/elevated_button_widget.dart';
import 'package:totp_authentication_app/widgets/buttons/icon_button_widget.dart';
import 'package:totp_authentication_app/widgets/buttons/text_button_widget.dart';
import 'package:totp_authentication_app/widgets/fields/code_totp_field_widget.dart';

/// A screen for validating a Time-based One-Time Password (TOTP) code.
class TOPTCodeValidationScreen extends StatefulWidget {
  const TOPTCodeValidationScreen({super.key});

  @override
  State<TOPTCodeValidationScreen> createState() =>
      _TOPTCodeValidationScreenState();
}

/// The state for the TOPTCodeValidationScreen.
class _TOPTCodeValidationScreenState extends State<TOPTCodeValidationScreen> {
  // Controller to manage the text input for the TOTP code field.
  final _codeController = TextEditingController();
  // Variable to control the enabled state of the confirm button.
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // Adds a listener that calls the `_onCodeChanged` function whenever the text changes.
    _codeController.addListener(_onCodeChanged);
  }

  @override
  void dispose() {
    // It's good practice to remove the listener before disposing of the controller to prevent memory leaks.
    _codeController.removeListener(_onCodeChanged);
    _codeController.dispose();
    super.dispose();
  }

  /// Function that is called on every change in the code field.
  void _onCodeChanged() {
    // Checks if the condition to enable the button (6 digits) has been met.
    final isComplete = _codeController.text.length == 6;

    // Only calls setState if the enabled state has actually changed, to optimize rebuilds.
    if (isComplete != _isButtonEnabled) {
      setState(() {
        _isButtonEnabled = isComplete;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gets the screen height for responsive spacing.
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: ProjectColorsTheme.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: _exitButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            _buildHeader(),
            SizedBox(height: screenHeight * 0.07),
            _buildCodeField(),
            SizedBox(height: screenHeight * 0.04),
            _buildConfirmButton(),
            SizedBox(height: screenHeight * 0.02),
            _buildResendCodeButton(),
          ],
        ),
      ),
    );
  }

  /// Builds the header with the screen's title and subtitle.
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: kPaddingSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            'Verificação', // "Verification"
            style: TextStyle(
              fontSize: kTitleFontSizeBig,
              fontWeight: FontWeight.bold,
              color: ProjectColorsTheme.textPrimary,
            ),
          ),
          TextWidget(
            'Insira o código que foi enviado:', // "Enter the code that was sent:"
            style: TextStyle(
              fontSize: kBodyFontSizeBig,
              color: ProjectColorsTheme.darkGrey,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the 6-digit code input field.
  Widget _buildCodeField() {
    return CodeTOTPFieldWidget(
      controller: _codeController,
      numberOfFields: 6,
      onCompleted: (code) {
        print('Code entered: $code');
        // You can call the verification function here.
      },
    );
  }

  /// Builds the main confirmation button.
  Widget _buildConfirmButton() {
    return ElevatedButtonWidget(
      text: TextWidget(
        'Confirmar', // "Confirm"
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: ProjectColorsTheme.white),
      ),
      isEnabled: _isButtonEnabled,
      onTap: () {
        print('Code confirmed: ${_codeController.text}');
      },
      buttonColor: ProjectColorsTheme.primaryColor,
      onButtonColor: ProjectColorsTheme.white,
      borderRadius: BorderRadius.circular(12),
      buttonHeight: MediaQuery.of(context).size.height * 0.06,
    );
  }

  /// Builds the text button to resend the code.
  Widget _buildResendCodeButton() {
    return Center(
      child: TextButtonWidget(
        icon: IconWidget(
          Icons.chat_bubble_outline_outlined,
          color: ProjectColorsTheme.primaryColor,
          size: MediaQuery.of(context).size.height * 0.025,
        ),
        text: 'Não recebi o código', // "I didn't receive the code"
        fontSize: kBodyFontSizeBig,
        textColor: ProjectColorsTheme.darkGrey,
        onTap: () {
          print('Requesting new code...');
        },
      ),
    );
  }

  /// Builds the back button for the AppBar.
  Widget _exitButton() {
    return IconButtonWidget(
      icon: Icons.arrow_back_ios,
      size: MediaQuery.of(context).size.height * 0.025,
      color: ProjectColorsTheme.primaryColor,
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}