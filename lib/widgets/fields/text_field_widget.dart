import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:totp_authentication_app/utils/constans_values.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';
import 'package:totp_authentication_app/widgets/basics/icon_widget.dart';
import 'package:totp_authentication_app/widgets/basics_widgets/text_widget.dart';

/// This [TextFieldWidget] is a custom widget that is used for data input across the app
class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final IconData? prefixIcon;
  final Widget? suffixWidget;
  final String? textLabel;
  final bool obscure;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool readOnly;
  final int? maxLines;
  final Function()? onTap;
  final List<TextInputFormatter> inputFormatters;
  final int? maxLength;
  final bool? useLabel;
  final Function(String)? onChanged;
  final String? hintText;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final Color? disabledColor;

  const TextFieldWidget({
    super.key,
    required this.controller,
    this.onTap,
    this.prefixIcon,
    this.suffixWidget,
    this.textLabel,
    this.validator,
    this.keyboardType,
    this.maxLength,
    this.onChanged,
    this.hintText,
    this.padding,
    this.maxLines = 1,
    this.obscure = false,
    this.useLabel = true,
    this.readOnly = false,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: kPaddingMedium),
    this.inputFormatters = const <TextInputFormatter>[],
    this.disabledColor = ProjectColorsTheme.backgroundWhite,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    // This build logic was used to avoid the padding and the column when their
    // values are null
    KeyboardVisibilityBuilder textFieldBuilder() {
      return KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return TextFormField(
            controller: widget.controller,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscure,
            readOnly: widget.readOnly,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hintText ??
                  (widget.textLabel != null
                      ? "Insira o(a) ${widget.textLabel!.toString().toLowerCase()}"
                      : null),
              hintStyle:
                  ProjectColorsTheme.appTheme.textTheme.bodyLarge!.copyWith(
                color: ProjectColorsTheme.neutralGrey,
              ),
              hintTextDirection: TextDirection.ltr,
              filled: true,
              fillColor: !widget.readOnly
                  ? ProjectColorsTheme.whiteColor
                  : widget.disabledColor,
              contentPadding: widget.prefixIcon != null
                  ? EdgeInsets.zero
                  : widget.contentPadding,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: widget.prefixIcon != null
                  ? IconWidget(widget.prefixIcon!)
                  : null,
              prefixIconColor:
                  WidgetStateColor.resolveWith((Set<WidgetState> states) {
                if (states.contains(WidgetState.error)) {
                  return ProjectColorsTheme.redColor;
                }
                return ProjectColorsTheme.primaryColor;
              }),
              suffixIcon: widget.suffixWidget,
              enabled: !widget.readOnly,
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kRadiusMedium),
                borderSide: const BorderSide(
                  color: ProjectColorsTheme.neutralGrey,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kRadiusMedium),
                borderSide: const BorderSide(
                  color: ProjectColorsTheme.neutralGrey,
                  width: 2,
                ),
              ),
              errorMaxLines: 2,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(kRadiusSmall)),
                borderSide: BorderSide(color: ProjectColorsTheme.neutralGrey),
              ),
            ),
          );
        },
      );
    }

    fieldWithLabel(bool condition) {
      if (condition) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: kPaddingVerySmall),
              child: TextWidget(
                widget.textLabel.toString(),
                type: TextType.textLarge,
              ),
            ),
            textFieldBuilder(),
          ],
        );
      } else {
        return textFieldBuilder();
      }
    }

    if (widget.padding != null) {
      return Padding(
        padding: widget.padding!,
        child: fieldWithLabel(widget.useLabel! && widget.textLabel != null),
      );
    } else {
      return fieldWithLabel(widget.useLabel! && widget.textLabel != null);
    }
  }
}
