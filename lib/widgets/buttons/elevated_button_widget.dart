// Import necessary packages from Flutter and project-specific files.
import 'package:flutter/material.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';

/// This [ElevatedButtonWidget] is a custom widget used for primary actions across the app.
class ElevatedButtonWidget extends StatelessWidget {

  
  // The widget to display as the button's content, typically a Text widget.
  final Widget text;
  // The callback function to execute when the button is pressed.
  final Function()? onTap;
  // The background color of the button.
  final Color? buttonColor;
  // The color of the content (e.g., text, icon) on the button.
  final Color? onButtonColor;
  // The border radius for the button's corners.
  final BorderRadius? borderRadius;
  // The height of the button.
  final double? buttonHeight;
  // A boolean to control if the button is enabled or disabled. Defaults to true.
  final bool isEnabled;

  // Constructor for the ElevatedButtonWidget.
  const ElevatedButtonWidget({
    super.key,
    required this.text,
    this.onTap,
    this.buttonColor,
    this.onButtonColor,
    this.borderRadius,
    this.buttonHeight,
    this.isEnabled = true,
  });

  @override
  // Describes the part of the user interface represented by this widget.
  Widget build(BuildContext context) {
    // Define the base color to avoid repetition, using the primary color as a fallback.
    final baseColor = buttonColor ?? ProjectColorsTheme.primaryColor;
    
    // Define the base color for the text/icon, defaulting to white.
    final onBaseColor = onButtonColor ?? Colors.white;

    // Use a SizedBox to enforce the height and make the button take the full width.
    return SizedBox(
      height: buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        // If `isEnabled` is true, use the onTap callback; otherwise, set to null to disable the button.
        onPressed: isEnabled ? onTap : null,
        // Defines the button's visual properties.
        style: ElevatedButton.styleFrom(
          // Color for the button when it IS enabled.
          backgroundColor: baseColor,
          // Color for the button when it IS disabled. Uses the base color with ~50% alpha.
          disabledBackgroundColor: baseColor.withAlpha(128), 

          // Color for the text/icon when it IS enabled.
          foregroundColor: onBaseColor,
          // Color for the text/icon when it IS disabled. Uses the text color with ~70% alpha.
          disabledForegroundColor: onBaseColor.withAlpha(179),
          
          // Defines the shape of the button, applying a border radius.
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.zero,
          ),
          // Set elevation to 0 for a flat design.
          elevation: 0,
        ),
        // The content of the button.
        child: text,
      ),
    );
  }
}