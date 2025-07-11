import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totp_authentication_app/auth/bloc_state_controller/auth_bloc.dart';
import 'package:totp_authentication_app/auth/bloc_state_controller/auth_events.dart';
import 'package:totp_authentication_app/auth/bloc_state_controller/auth_state.dart';
import 'package:totp_authentication_app/utils/constans_values.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';
import 'package:totp_authentication_app/widgets/basics/text_widget.dart';
import 'package:totp_authentication_app/widgets/buttons/elevated_button_widget.dart';
import 'package:totp_authentication_app/widgets/buttons/text_button_widget.dart';
import 'package:totp_authentication_app/widgets/fields/text_field_widget.dart';
import 'package:totp_authentication_app/widgets/snackbar/app_snackbar_widget.dart';

// Defines the LoginScreen as a stateful widget.
class LoginScreen extends StatefulWidget {
  // Constant constructor for the widget.
  const LoginScreen({super.key});

  // Creates the mutable state for this widget.
  @override
  // Returns a new instance of the _LoginScreenState.
  State<LoginScreen> createState() => _LoginScreenState();
}

// The state class for the LoginScreen widget.
class _LoginScreenState extends State<LoginScreen> {
  // A controller for the username text field.
  final _userNameController = TextEditingController();
  // A controller for the password text field.
  final _passwordController = TextEditingController();

  // Called when this state object is inserted into the tree.
  @override
  // Initializes the state.
  void initState() {
    // Calls the initState of the superclass.
    super.initState();
    // Gets the initial state from the AuthBloc.
    final initialState = context.read<AuthBloc>().state;
    // Sets the initial text for the username controller.
    _userNameController.text = initialState.username;
    // Sets the initial text for the password controller.
    _passwordController.text = initialState.password;
  }

  // Called when this state object is removed from the tree permanently.
  @override
  // Disposes of the resources used by the state.
  void dispose() {
    // Disposes the username controller to free up resources.
    _userNameController.dispose();
    // Disposes the password controller to free up resources.
    _passwordController.dispose();
    // Calls the dispose method of the superclass.
    super.dispose();
  }

  // Describes the part of the user interface represented by this widget.
  @override
  // The build method returns the widget tree.
  Widget build(BuildContext context) {
    // Listens to state changes in AuthBloc to perform side effects.
    return BlocListener<AuthBloc, AuthState>(
      // The function to call when a state change occurs.

      listener: (context, state) async {
        // Checks if the username in the state differs from the controller's text.
        if (state.username != _userNameController.text) {
          // Updates the controller's text to match the state.
          _userNameController.text = state.username;
        }
        // Checks if the password in the state differs from the controller's text.
        if (state.password != _passwordController.text) {
          // Updates the controller's text to match the state.
          _passwordController.text = state.password;
        }

        // Checks if the state is a LOGIN failure and the current route is active.
        if (state is AuthLoginFailure && ModalRoute.of(context)!.isCurrent) {
          // Shows an error snackbar with the failure message.
          AppSnackbarWidget.showError(context: context, message: state.message);
          // Checks if the state indicates a successful authentication.
        } else if (state is AuthSuccess) {
          // Replaces the current screen with the home screen.
          Navigator.of(context).pushReplacementNamed('/home');
          // Checks if secret recovery is required and the current route is active.
        } else if (state is AuthRequiresSecretRecovery &&
            ModalRoute.of(context)!.isCurrent) {
          // Awaits the closing of the recovery screen.
          await Navigator.of(context).pushNamed('/recovery');

          // Checks if the widget is still mounted before using its context.
          if (!context.mounted) return;

          // Dispatches an event to reset the authentication state.
          context.read<AuthBloc>().add(AuthStateReset());
        }
      },
      // The main UI of the screen.
      child: Scaffold(
        // Sets the background color of the screen.
        backgroundColor: ProjectColorsTheme.white,
        // Ensures the content is within the safe area of the screen.
        body: SafeArea(
          // Allows the screen content to be scrollable.
          child: SingleChildScrollView(
            // A box that forces its child to have a minimum height.
            child: ConstrainedBox(
              // Sets the minimum height to the screen's height minus top padding.
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
              ),
              // A widget that sizes its child to the child's intrinsic height.
              child: IntrinsicHeight(
                // The main layout column for the screen.
                child: Column(
                  // Stretches the children to fill the horizontal space.
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // The children widgets of the column.
                  children: [
                    // A flexible spacer that takes up available space.
                    const Spacer(),
                    // Builds the header section of the screen.
                    _buildHeader(context),
                    // Builds the form section of the screen.
                    _buildForm(context),
                    // A flexible spacer that takes up available space.
                    const Spacer(),
                    // Builds the footer section of the screen.
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

  // Builds the header widget containing the login image.
  Widget _buildHeader(BuildContext context) {
    // A column to arrange widgets vertically.
    return Column(
      // The children of the column.
      children: [
        // Displays an image from the asset bundle.
        Image.asset(
          // The path to the image asset.
          'lib/assets/images/login_image.png',
          // Makes the image take the full width available.
          width: double.infinity,
          // Scales the image to fit the width.
          fit: BoxFit.fitWidth,
        ),
        // A box for vertical spacing, proportional to the screen height.
        SizedBox(height: MediaQuery.of(context).size.height * 0.06),
      ],
    );
  }

  // Builds the form widget containing the text fields and login button.
  Widget _buildForm(BuildContext context) {
    // Adds padding around the form column.
    return Padding(
      // Sets the padding value.
      padding: const EdgeInsets.all(kPaddingMedium),
      // A column to arrange form elements vertically.
      child: Column(
        // The children of the column.
        children: [
          // Builds the username input field.
          _userNameField(),
          // A box for vertical spacing.
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          // Builds the password input field.
          _passwordField(),
          // A box for vertical spacing.
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          // Builds the login button.
          _loginButton(),
        ],
      ),
    );
  }

  // Builds the footer widget containing the 'forgot password' button.
  Widget _buildFooter(BuildContext context) {
    // Adds padding around the footer content.
    return Padding(
      // Sets horizontal and vertical padding values.
      padding: const EdgeInsets.symmetric(
          horizontal: kPaddingBig, vertical: kPaddingVerySmall * 10),
      // Builds the 'forgot password' text button.
      child: _forgotPasswordButton(),
    );
  }

  // Builds the password text field widget.
  Widget _passwordField() {
    // Returns a custom text field widget.
    return TextFieldWidget(
      // Assigns the password controller.
      controller: _passwordController,
      // Sets the label for the text field.
      textLabel: 'Senha',
      // Obscures the text for password input.
      obscure: true,
      // Uses a borderless style for the text field.
      isBorderless: true,
      // Callback that dispatches an event when the text changes.
      onChanged: (password) {
        // Dispatches the AuthPasswordChanged event to the BLoC.
        context.read<AuthBloc>().add(AuthPasswordChanged(password));
      },
    );
  }

  // Builds the username text field widget.
  Widget _userNameField() {
    // Returns a custom text field widget.
    return TextFieldWidget(
      // Assigns the username controller.
      controller: _userNameController,
      // Sets the label for the text field.
      textLabel: 'E-mail',
      // Sets the keyboard type for text input.
      keyboardType: TextInputType.text,
      // Uses a borderless style for the text field.
      isBorderless: true,
      // Callback that dispatches an event when the text changes.
      onChanged: (username) {
        // Dispatches the AuthUsernameChanged event to the BLoC.
        context.read<AuthBloc>().add(AuthUsernameChanged(username));
      },
    );
  }

  // Builds the login button widget.
  Widget _loginButton() {
    // Rebuilds the button based on AuthBloc state changes.
    return BlocBuilder<AuthBloc, AuthState>(
      // Optimizes rebuilds to only occur for specific states.
      buildWhen: (previous, current) =>
          current is AuthLoading || current is AuthReadyToLogin,
      // The builder function that creates the widget.
      builder: (context, state) {
        // Determines if the UI should be in a loading state.
        final isLoading = state is AuthLoading;
        // Determines if the button should be enabled.
        final isEnabled = !isLoading &&
            _userNameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty;

        // Returns a custom elevated button widget.
        return ElevatedButtonWidget(
          // Sets the button's content based on the loading state.
          text: isLoading
              // Shows a progress indicator when loading.
              ? const CircularProgressIndicator(color: Colors.white)
              // Shows a text widget when not loading.
              : TextWidget(
                  // The text to display on the button.
                  'Entrar',
                  // The style for the button text.
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: kBodyFontSizeBig,
                      color: ProjectColorsTheme.white),
                ),
          // Sets the enabled state of the button.
          isEnabled: isEnabled,
          // The callback function to execute when the button is tapped.
          onTap: isEnabled
              // If enabled, dispatches the login submission event.
              ? () {
                  // Dispatches the AuthLoginSubmitted event to the BLoC.
                  context.read<AuthBloc>().add(AuthLoginSubmitted());
                }
              // If disabled, the onTap callback is null.
              : null,
          // Sets the background color of the button.
          buttonColor: ProjectColorsTheme.primaryColor,
          // Sets the color of the content when the button is pressed.
          onButtonColor: ProjectColorsTheme.white,
          // Sets the border radius of the button.
          borderRadius: BorderRadius.circular(kRadiusStandard),
          // Sets the height of the button.
          buttonHeight: MediaQuery.of(context).size.height * 0.06,
        );
      },
    );
  }

  // Builds the 'forgot password' text button widget.
  Widget _forgotPasswordButton() {
    // Returns a custom text button widget.
    return TextButtonWidget(
      // The text to display on the button.
      text: 'Esqueci a senha',
      // The font size for the button text.
      fontSize: kBodyFontSizeBig,
      // The color of the button text.
      textColor: ProjectColorsTheme.primaryColor,
      // The callback function to execute when tapped.
      onTap: () {},
    );
  }
}
