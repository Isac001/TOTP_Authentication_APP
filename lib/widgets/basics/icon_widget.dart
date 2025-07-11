import 'package:flutter/material.dart';
import 'package:totp_authentication_app/utils/constans_values.dart';

/// This [IconWidget] class is responsible for creating a reusable icon component,
/// with optional padding and a decorative background.
class IconWidget extends StatelessWidget {
  // The data for the icon to be displayed (e.g., Icons.add).
  final IconData icon;
  // The size of the icon in logical pixels.
  final double? size;
  // The color to use when drawing the icon.
  final Color? color;
  // Optional padding to apply around the icon.
  final EdgeInsetsGeometry? padding;
  // If true, the icon will be rendered inside a decorative circle.
  final bool? hasBackground;

  // Constructor for the IconWidget.
  const IconWidget(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.padding,
    this.hasBackground = false,
  });

  @override
  // Describes the part of the user interface represented by this widget.
  Widget build(BuildContext context) {
    // A local function to build the core Icon widget, avoiding code repetition.
    Icon iconBuild() {
      return Icon(
        icon,
        size: size,
        color: color,
      );
    }

    // Checks if the icon should have a background decoration.
    if (hasBackground!) {
      // If a background is requested, wrap the icon in a DecoratedBox.
      return DecoratedBox(
        // The decoration provides a circular shape and a background color
        // derived from the icon's color with low opacity.
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusXLarge),
          color: color?.withAlpha(30),
        ),
        // Conditionally applies padding inside the decorated box if provided.
        child: padding != null
            ? Padding(
                padding: padding!,
                child: iconBuild(),
              )
            : iconBuild(),
      );
    } else {
      // If no background is needed, handle the padding separately.
      if (padding != null) {
        // If padding is provided (without a background), wrap the icon in a Padding widget.
        return Padding(
          padding: padding!,
          child: iconBuild(),
        );
      } else {
        // If there's no background and no padding, just return the basic icon.
        return iconBuild();
      }
    }
  }
}
