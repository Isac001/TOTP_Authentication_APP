// Import necessary packages from Flutter and project-specific files.
import 'package:flutter/material.dart';
import 'package:totp_authentication_app/utils/constans_values.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';
import 'package:totp_authentication_app/widgets/basics/icon_widget.dart';

/// This [IconButtonWidget] is a custom widget that wraps a standard IconButton
/// to provide a consistent look and feel across the app.
class IconButtonWidget extends StatelessWidget {
  // The icon data to be displayed inside the button.
  final IconData icon;
  // The size of the icon.
  final double size;
  // The color of the icon. Defaults to the project's primary color.
  final Color? color;
  // The callback function that is triggered when the button is tapped.
  final Function()? onTap;

  // Constructor for the IconButtonWidget.
  const IconButtonWidget({
    super.key,
    required this.icon,
    this.onTap,
    this.color = ProjectColorsTheme.primaryColor,
    this.size = kButtonHeightSmall,
  });

  @override
  // Describes the part of the user interface represented by this widget.
  Widget build(BuildContext context) {
    // Returns a standard IconButton from Flutter.
    return IconButton(
      // Assigns the provided callback function to the button's pressed event.
      onPressed: onTap,
      // The actual icon displayed, built using another custom widget `IconWidget`.
      icon: IconWidget(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}