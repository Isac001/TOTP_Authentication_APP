import 'package:flutter/material.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';

/// Enum that defines the semantic text types for styling.
enum TextType {
  titleLarge,
  titleMedium,
  titleSmall,
  textLarge,
  textMedium,
  textSmall,
}

/// This [TextWidget] class is responsible for creating a consistent text component used in the app.
class TextWidget extends StatelessWidget {
  // The string content to be displayed.
  final String text;
  // The semantic type of the text, which determines its base style.
  final TextType type;
  // An optional TextStyle to override or extend the base style from the theme.
  final TextStyle? style;
  // The maximum number of lines for the text to span.
  final int maxLines;
  // How visual overflow should be handled.
  final TextOverflow? overflow;
  // How the text should be aligned horizontally.
  final TextAlign? textAlign;
  // If true, the text will be converted to uppercase.
  final bool isUppercase;
  // Optional padding to apply around the text widget.
  final EdgeInsetsGeometry? padding;

  // Constructor for the TextWidget.
  const TextWidget(
    this.text, {
    super.key,
    this.padding,
    this.overflow,
    this.style,

    // Setting default values.
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.isUppercase = false,
    this.type = TextType.textMedium,
  });

  // ADDED METHOD: Returns the final calculated style.
  // This allows other widgets to access the calculated text style.
  TextStyle getTextStyle() {
    // Merges the base style from the theme with specific overrides from the `style` property.
    return _styleSetter(type).copyWith(
      color: style?.color,
      fontSize: style?.fontSize,
      fontWeight: style?.fontWeight,
    );
  }

  @override
  // Describes the part of the user interface represented by this widget.
  Widget build(BuildContext context) {
    // This local function builds the core Text widget to avoid code repetition.
    Widget textBuild() {
      return Text(
        // Conditionally converts the text to uppercase.
        isUppercase ? text.toUpperCase() : text,
        overflow: overflow,
        softWrap: true,
        textAlign: textAlign,
        maxLines: maxLines,
        // Uses the new method to get the final combined style.
        style: getTextStyle(),
      );
    }

    // If padding is provided, wrap the text component in a Padding widget.
    if (padding != null) {
      return Padding(
        padding: padding!,
        child: textBuild(),
      );
    } else {
      // Otherwise, return the text component directly.
      return textBuild();
    }
  }

  // A private helper function that returns a specific TextStyle from the app theme based on the provided TextType.
  TextStyle _styleSetter(TextType type) {
    switch (type) {
      case TextType.titleLarge:
        return ProjectColorsTheme.appTheme.textTheme.titleLarge!;
      case TextType.titleMedium:
        return ProjectColorsTheme.appTheme.textTheme.titleMedium!;
      case TextType.titleSmall:
        return ProjectColorsTheme.appTheme.textTheme.titleSmall!;
      case TextType.textLarge:
        return ProjectColorsTheme.appTheme.textTheme.bodyLarge!;
      case TextType.textMedium:
        return ProjectColorsTheme.appTheme.textTheme.bodyMedium!;
      case TextType.textSmall:
        return ProjectColorsTheme.appTheme.textTheme.bodySmall!;
    }
  }
}