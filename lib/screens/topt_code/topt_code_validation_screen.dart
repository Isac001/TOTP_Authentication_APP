import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totp_authentication_app/auth/bloc_state_controller/auth_bloc.dart';
import 'package:totp_authentication_app/auth/bloc_state_controller/auth_events.dart';
import 'package:totp_authentication_app/auth/bloc_state_controller/auth_state.dart';
import 'package:totp_authentication_app/utils/constans_values.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';
import 'package:totp_authentication_app/widgets/basics/icon_widget.dart';
import 'package:totp_authentication_app/widgets/basics/text_widget.dart';
import 'package:totp_authentication_app/widgets/buttons/elevated_button_widget.dart';
import 'package:totp_authentication_app/widgets/buttons/icon_button_widget.dart';
import 'package:totp_authentication_app/widgets/buttons/text_button_widget.dart';
import 'package:totp_authentication_app/widgets/fields/code_totp_field_widget.dart';
import 'package:totp_authentication_app/widgets/snackbar/app_snackbar_widget.dart';

// Defines the screen for TOTP code validation and secret recovery.
class TOPTCodeValidationScreen extends StatefulWidget {
  const TOPTCodeValidationScreen({super.key});

  @override
  // Returns a new instance of the _TOPTCodeValidationScreenState.
  State<TOPTCodeValidationScreen> createState() =>
      _TOPTCodeValidationScreenState();
}

// The state class for the TOPTCodeValidationScreen widget.
class _TOPTCodeValidationScreenState extends State<TOPTCodeValidationScreen> {
  // A controller for the code input text field.
  final _codeController = TextEditingController();

  @override
  // Disposes of the resources used by the state.
  void dispose() {
    // Disposes the code controller to free up resources.
    _codeController.dispose();
    // Calls the dispose method of the superclass.
    super.dispose();
  }

  // Describes the part of the user interface represented by this widget.
  @override
  // The build method returns the widget tree.
  Widget build(BuildContext context) {
    // A widget that combines a BlocListener and a BlocBuilder.
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // Checks if the state is a RECOVERY failure and the current route is active.
        if (state is AuthRecoveryFailure && ModalRoute.of(context)!.isCurrent) {
          // Shows a custom error snackbar.
          AppSnackbarWidget.showError(context: context, message: state.message);
          // Checks if the state indicates the user is ready to log in (e.g., after successful recovery).
        } else if (state is AuthReadyToLogin) {
          // Checks if the navigator can pop the current route.
          if (Navigator.canPop(context)) {
            // Pops the current route to return to the previous screen.
            Navigator.of(context).pop();
            // If popping is not possible, this is a fallback.
          } else {
            // Replaces the current screen with the login screen.
            Navigator.of(context).pushReplacementNamed('/login');
          }
        }
      },
      // Optimizes rebuilds by specifying when the builder should run.
      buildWhen: (previous, current) {
        // Rebuilds only if the state is loading or recovery-ready.
        return current is AuthLoading || current is AuthRecoveryReady;
      },
      // The builder function that creates the widget's UI.
      builder: (context, state) {
        // Returns the main scaffold for the screen.
        return Scaffold(
          // Sets the background color of the screen.
          backgroundColor: ProjectColorsTheme.white,
          // Defines the app bar at the top of the screen.
          appBar: AppBar(
            // Sets the elevation of the app bar to zero.
            elevation: 0,
            // Makes the app bar background transparent.
            backgroundColor: Colors.transparent,
            // Sets the leading widget in the app bar (the back button).
            leading: _exitButton(),
            // Centers the title in the app bar.
            centerTitle: true,
          ),
          // The main content of the screen.
          body: SingleChildScrollView(
            // Adds horizontal padding to the content.
            padding: const EdgeInsets.symmetric(horizontal: kPaddingMedium),
            // The main layout column for the screen's content.
            child: Column(
              // Aligns children to the start (left) of the cross axis.
              crossAxisAlignment: CrossAxisAlignment.start,
              // The list of children widgets in the column.
              children: [
                // A box for vertical spacing.
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                // Builds the header section.
                _buildHeader(),
                // A box for vertical spacing.
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                // Builds the code input field.
                _buildCodeField(),
                // A box for vertical spacing.
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                // Builds the confirmation button, passing the current state.
                _buildConfirmButton(state),
                // A box for vertical spacing.
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                // Builds the 'resend code' button.
                _buildResendCodeButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  // Builds the header widget containing titles and descriptions.
  Widget _buildHeader() {
    // Adds padding to the bottom of the header.
    return Padding(
      // Sets the padding value.
      padding: const EdgeInsets.only(bottom: kPaddingSmall),
      // A column to arrange header texts vertically.
      child: Column(
        // Aligns children to the start (left).
        crossAxisAlignment: CrossAxisAlignment.start,
        // The list of text widgets.
        children: [
          // The main title text widget.
          TextWidget(
            // The text for the title.
            'Recuperação de Secret',
            // The style for the title text.
            style: TextStyle(
              // Sets the font size.
              fontSize: kTitleFontSizeBig,
              // Sets the font weight to bold.
              fontWeight: FontWeight.bold,
              // Sets the text color.
              color: ProjectColorsTheme.textPrimary,
            ),
          ),
          // The subtitle text widget.
          TextWidget(
            // The text for the subtitle.
            'Insira o código de recuperação fornecido para configurar sua conta.',
            // The style for the subtitle text.
            style: TextStyle(
              // Sets the font size.
              fontSize: kBodyFontSizeBig,
              // Sets the text color.
              color: ProjectColorsTheme.darkGrey,
            ),
          ),
        ],
      ),
    );
  }

  // Builds the code input field widget.
  Widget _buildCodeField() {
    // Returns a custom widget for TOTP code input.
    return CodeTOTPFieldWidget(
      // Assigns the code controller.
      controller: _codeController,
      // Sets the number of fields for the code.
      numberOfFields: 6,
      // Callback that dispatches an event when the text changes.
      onChanged: (code) {
        // Dispatches the AuthRecoveryCodeChanged event to the BLoC.
        context.read<AuthBloc>().add(AuthRecoveryCodeChanged(code));
      },
    );
  }

  // Builds the confirmation button widget.
  Widget _buildConfirmButton(AuthState state) {
    // Determines if the UI should be in a loading state.
    final isLoading = state is AuthLoading;
    // Determines if the button should be enabled based on state validation.
    final isEnabled = !isLoading && state.isRecoveryCodeValid;

    // Returns a custom elevated button widget.
    return ElevatedButtonWidget(
      // Sets the button's content based on the loading state.
      text: isLoading
          // Shows a progress indicator when loading.
          ? const CircularProgressIndicator(color: Colors.white)
          // Shows a text widget when not loading.
          : TextWidget(
              'Recuperar',
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: kBodyFontSizeBig,
                  color: ProjectColorsTheme.white),
            ),
      // Sets the enabled state of the button.
      isEnabled: isEnabled,
      // The callback function to execute when the button is tapped.
      onTap: isEnabled
          // If enabled, dispatches the secret recovery request event.
          ? () {
              // Dispatches the event with the code from the controller.
              context.read<AuthBloc>().add(
                    AuthSecretRecoveryRequested(
                        recoveryCode: _codeController.text),
                  );
            }
          // If disabled, the onTap callback is null.
          : null,
      // Sets the background color of the button.
      buttonColor: ProjectColorsTheme.primaryColor,
      // Sets the color of the content when the button is pressed.
      onButtonColor: ProjectColorsTheme.white,
      // Sets the border radius of the button.
      borderRadius: BorderRadius.circular(12),
      // Sets the height of the button.
      buttonHeight: MediaQuery.of(context).size.height * 0.06,
    );
  }

  // Builds the 'resend code' text button widget.
  Widget _buildResendCodeButton() {
    // Centers the button horizontally.
    return Center(
      // Returns a custom text button widget.
      child: TextButtonWidget(
        // The icon to display on the button.
        icon: IconWidget(
          Icons.chat_bubble_outline_outlined,
          color: ProjectColorsTheme.primaryColor,
          size: MediaQuery.of(context).size.height * 0.025,
        ),
        // The text to display on the button.
        text: 'Não recebi o código',
        fontSize: kBodyFontSizeBig,
        textColor: ProjectColorsTheme.darkGrey,
        // The callback function to execute when tapped.
        onTap: () {
          // This action is not yet implemented.
        },
      ),
    );
  }

  // Builds the exit/back button for the app bar.
  Widget _exitButton() {
    // Returns a custom icon button widget.
    return IconButtonWidget(
      // The icon data for the button.
      icon: Icons.arrow_back_ios,
      size: MediaQuery.of(context).size.height * 0.025,
      color: ProjectColorsTheme.primaryColor,
      // The callback function to execute when tapped.
      onTap: () {
        // Checks if it is possible to go back in the navigation stack.
        if (Navigator.canPop(context)) {
          // Pops the current route off the navigator.
          Navigator.of(context).pop();
        }
      },
    );
  }
}
