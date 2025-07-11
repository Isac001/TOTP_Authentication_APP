// Import necessary packages from Flutter and project-specific files.
import 'package:flutter/material.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';
import 'package:totp_authentication_app/widgets/basics/text_widget.dart';

/// This [TextButtonWidget] is a custom stateless widget that creates a text button,
/// optionally with an icon.
class TextButtonWidget extends StatelessWidget {
  // The text to display on the button.
  final String text;
  // CHANGE: The parameter type is now 'Widget' to accept an IconWidget or other custom icons.
  // An optional widget (typically an icon) to display before the text.
  final Widget? icon;
  // An optional color for the button's text.
  final Color? textColor;
  // An optional font size for the button's text.
  final double? fontSize;
  // The callback function that is executed when the button is tapped.
  final Function()? onTap;
  // Optional padding to wrap around the button.
  final EdgeInsetsGeometry? padding;

  // Constructor for the TextButtonWidget.
  const TextButtonWidget({
    super.key,
    required this.text,
    this.icon,
    this.textColor,
    this.fontSize,
    this.onTap,
    this.padding,
  });

  @override
  // Describes the part of the user interface represented by this widget.
  Widget build(BuildContext context) {
    // A local function to build the final TextButton widget.
    TextButton textButtonBuild() {
      // Checks if an icon (now as a widget) has been provided.
      if (icon != null) {
        // If an icon is present, create a TextButton with an icon.
        return TextButton.icon(
          onPressed: onTap,
          // CHANGE: We directly use the icon widget that was passed.
          icon: icon!,
          // The label for the button, using the custom TextWidget.
          label: TextWidget(
            text,
            style: ProjectColorsTheme.appTheme.textTheme.bodyLarge!.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
          // Defines the style of the button, specifically its foreground (text/icon) color.
          style: TextButton.styleFrom(
            foregroundColor: textColor ?? ProjectColorsTheme.primaryColor,
          ),
        );
      } else {
        // If no icon is provided, the behavior is the same as a standard TextButton.
        return TextButton(
          onPressed: onTap,
          // Defines the style of the button.
          style: TextButton.styleFrom(
            foregroundColor: textColor ?? ProjectColorsTheme.primaryColor,
          ),
          // The child of the button, using the custom TextWidget.
          child: TextWidget(
            text,
            style: ProjectColorsTheme.appTheme.textTheme.bodyLarge!.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        );
      }
    }

    // If padding is specified, wrap the button in a Padding widget.
    if (padding != null) {
      return Padding(
        padding: padding!,
        child: textButtonBuild(),
      );
    } else {
      // Otherwise, return the button directly.
      return textButtonBuild();
    }
  }
}