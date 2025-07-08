import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:totp_authentication_app/utils/constans_values.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';
import 'package:totp_authentication_app/widgets/basics/icon_widget.dart';
import 'package:totp_authentication_app/widgets/basics_widgets/text_widget.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? buttonColor;
  final Color? onButtonColor;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final double? buttonHeight;
  final double? buttonWidth;

  const ElevatedButtonWidget({
    super.key,
    required this.text,
    this.icon,
    this.buttonColor,
    this.onButtonColor,
    this.onTap,
    this.buttonHeight,
    this.buttonWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    // This build logic was used to avoid the padding and the column when their
    // values are null
    ElevatedButton elevatedButtonBuild() {
      if (icon != null) {
        return ElevatedButton.icon(
          onPressed: onTap,
          icon: IconWidget(
            icon!,
            color: onButtonColor,
            size: ProjectColorsTheme.appTheme.textTheme.bodyLarge!.fontSize! *
                1.5,
          ),
          label: TextWidget(
            text,
            style: ProjectColorsTheme.appTheme.textTheme.bodyLarge!
                .copyWith(color: onButtonColor),
          ),
          style:
              ProjectColorsTheme.appTheme.elevatedButtonTheme.style!.copyWith(
            backgroundColor: WidgetStatePropertyAll(buttonColor),
            fixedSize: WidgetStatePropertyAll(
              Size(buttonWidth ?? Get.width,
                  buttonHeight ?? kButtonHeightMedium),
            ),
            alignment: Alignment.centerLeft,
          ),
        );
      } else {
        return ElevatedButton(
          onPressed: onTap,
          style:
              ProjectColorsTheme.appTheme.elevatedButtonTheme.style!.copyWith(
            backgroundColor: WidgetStatePropertyAll(buttonColor),
          ),
          child: TextWidget(
            text,
            style: ProjectColorsTheme.appTheme.textTheme.bodyLarge!.copyWith(
                color: onButtonColor ?? ProjectColorsTheme.whiteColor),
          ),
        );
      }
    }

    if (padding != null) {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: elevatedButtonBuild(),
      );
    } else {
      return elevatedButtonBuild();
    }
  }
}
