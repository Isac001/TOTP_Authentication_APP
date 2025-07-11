import 'package:flutter/material.dart';
import 'package:totp_authentication_app/utils/constans_values.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';
import 'package:totp_authentication_app/widgets/basics/text_widget.dart';

/// This [AppSnackbarWidget] is a custom widget for create Snackbars in the app design.
class AppSnackbarWidget {
  // A static method to show a custom error Snackbar.
  static void showError(
      // Requires the BuildContext to find the ScaffoldMessenger.
      {required BuildContext context, required String message}) {
    // Ensures any currently visible Snackbar is hidden before showing a new one.
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Creates and displays the new Snackbar.
    ScaffoldMessenger.of(context).showSnackBar(
      // The SnackBar widget with custom styling.
      SnackBar(
        // The main content of the Snackbar.
        content: TextWidget(
          // The error message to be displayed.
          message,
          // The style for the message text.
          style: const TextStyle(
            // Sets the text color to white.
            color: Colors.white,
            // Sets the font weight.
            fontWeight: FontWeight.w500,
          ),
        ),

        // Sets the background color of the Snackbar.
        backgroundColor: ProjectColorsTheme.textPrimary,
        // Makes the Snackbar float above the content.
        behavior:
            SnackBarBehavior.floating,
        // Sets a slight shadow for elevation.
        elevation: kPaddingVerySmall,
        // Defines the shape of the Snackbar with rounded corners.
        shape: RoundedRectangleBorder(
          // Sets the border radius.
          borderRadius: BorderRadius.circular(kRadiusLarge),
        ),
        // Sets the margin for the floating behavior.
        margin:
            const EdgeInsets.all(kPaddingMedium),

        // The duration for which the Snackbar is visible.
        duration: const Duration(seconds: 4),
      ),
    );
  }
}