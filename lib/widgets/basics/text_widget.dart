import 'package:flutter/material.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';

/// Enum that defines the text types.
enum TextType {
  titleLarge,
  titleMedium,
  titleSmall,
  textLarge,
  textMedium,
  textSmall,
}

/// This [TextWidget] class is responsible for creating a text component used in the app.
class TextWidget extends StatelessWidget {
  final String text;
  final TextType type;
  final TextStyle? style;
  final int maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool isUppercase;
  final EdgeInsetsGeometry? padding;

  const TextWidget(
    this.text, {
    super.key,
    this.padding,
    this.overflow,
    this.style,

    // Setting defaults values
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.isUppercase = false,
    this.type = TextType.textMedium,
  });

  @override
  Widget build(BuildContext context) {
    // This build logic was used to avoid the padding when your
    // value is null
    Widget textBuild() {
      return Text(
        isUppercase ? text.toUpperCase() : text,
        overflow: overflow,
        softWrap: true,
        textAlign: textAlign,
        maxLines: maxLines,
        style: _styleSetter(type).copyWith(
          color: style?.color,
          fontSize: style?.fontSize,
          fontWeight: style?.fontWeight,
        ),
      );
    }

    if (padding != null) {
      return Padding(
        padding: padding!,
        child: textBuild(),
      );
    } else {
      return textBuild();
    }
  }

  // Function that sets the style of the text.
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