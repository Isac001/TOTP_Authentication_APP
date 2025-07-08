import 'package:flutter/material.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';
import 'package:totp_authentication_app/widgets/basics/icon_widget.dart';
import 'package:totp_authentication_app/widgets/basics_widgets/text_widget.dart';

class TextButtonWidget extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? textColor;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;

  const TextButtonWidget({
    super.key,
    required this.text,
    this.icon,
    this.textColor,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    // Função interna para construir o botão, mantendo o código organizado.
    TextButton textButtonBuild() {
      // Verifica se um ícone foi fornecido.
      if (icon != null) {
        return TextButton.icon(
          onPressed: onTap,
          icon: IconWidget(
            icon!,
            color: textColor,
            // A lógica para o tamanho do ícone foi mantida como no seu ElevatedButton
            size: ProjectColorsTheme.appTheme.textTheme.bodyLarge!.fontSize! * 1.5,
          ),
          label: TextWidget(
            text,
            style: ProjectColorsTheme.appTheme.textTheme.bodyLarge!.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold, // TextButtons geralmente têm um peso maior
            ),
          ),
          // Usamos TextButton.styleFrom para uma estilização mais limpa
          style: TextButton.styleFrom(
            foregroundColor: textColor ?? ProjectColorsTheme.primaryColor,
          ),
        );
      } else {
        // Caso não tenha ícone, usa o construtor padrão.
        return TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            foregroundColor: textColor ?? ProjectColorsTheme.primaryColor,
          ),
          child: TextWidget(
            text,
            style: ProjectColorsTheme.appTheme.textTheme.bodyLarge!.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    }

    // Aplica o padding apenas se ele for fornecido, assim como no seu widget original.
    if (padding != null) {
      return Padding(
        padding: padding!,
        child: textButtonBuild(),
      );
    } else {
      return textButtonBuild();
    }
  }
}