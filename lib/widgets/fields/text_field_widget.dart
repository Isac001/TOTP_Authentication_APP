// Import necessary packages from Flutter and other dependencies.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:totp_authentication_app/utils/constans_values.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';
import 'package:totp_authentication_app/widgets/basics/icon_widget.dart';
import 'package:totp_authentication_app/widgets/basics/text_widget.dart';

/// This [TextFieldWidget] is a custom widget that is used for data input across the app.
class TextFieldWidget extends StatefulWidget {
  // Controller for the text field to manage its content.
  final TextEditingController controller;
  // Optional icon to display before the text input area.
  final IconData? prefixIcon;
  // Optional widget to display at the end of the text field.
  final Widget? suffixWidget;
  // The text that describes the input field, used as a label or hint.
  final String? textLabel;
  // Whether to obscure the text being entered, useful for passwords.
  final bool obscure;
  // The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;
  // Validator function to check if the input is valid.
  final String? Function(String?)? validator;
  // If true, the text field cannot be edited.
  final bool readOnly;
  // The maximum number of lines the text field can have.
  final int? maxLines;
  // A callback function that is triggered when the text field is tapped.
  final Function()? onTap;
  // A list of formatters to apply to the input.
  final List<TextInputFormatter> inputFormatters;
  // The maximum number of characters allowed in the input.
  final int? maxLength;
  // Determines whether to display a label above the text field.
  final bool? useLabel;
  // A callback function that is triggered when the text field's value changes.
  final Function(String)? onChanged;
  // Hint text to display when the text field is empty.
  final String? hintText;
  // Optional padding to apply around the entire widget.
  final EdgeInsetsGeometry? padding;
  // Optional padding for the content within the text field.
  final EdgeInsetsGeometry? contentPadding;
  // The color to use for the fill when the text field is disabled/readonly.
  final Color? disabledColor;
  // If true, the text field will have no visible border.
  final bool isBorderless;
  // CHANGE 1: Adding the new optional color parameter.
  // Optional color for the label text, used for both the external label and the internal hint in borderless mode.
  final Color? labelColor;

  // Constructor for the TextFieldWidget.
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
    this.contentPadding,
    this.inputFormatters = const <TextInputFormatter>[],
    this.disabledColor = ProjectColorsTheme.white,
    this.isBorderless = false,
    this.labelColor, // Adding to the constructor.
  });

  @override
  // Creates the mutable state for this widget at a given location in the tree.
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

// The state class for the TextFieldWidget.
class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  // Describes the part of the user interface represented by this widget.
  Widget build(BuildContext context) {
    // A local function to build the core TextFormField.
    KeyboardVisibilityBuilder textFieldBuilder() {
      // Uses KeyboardVisibilityBuilder to rebuild the widget when keyboard visibility changes, if needed.
      return KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          // The actual text input field.
          return TextFormField(
            // Sets the controller for the text field.
            controller: widget.controller,
            // Hides the keyboard when tapping outside the text field.
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            // Sets the maximum number of lines.
            maxLines: widget.maxLines,
            // Sets the maximum length of the input.
            maxLength: widget.maxLength,
            // Sets the onTap callback.
            onTap: widget.onTap,
            // Sets the onChanged callback.
            onChanged: widget.onChanged,
            // Applies input formatters.
            inputFormatters: widget.inputFormatters,
            // Sets the keyboard type.
            keyboardType: widget.keyboardType,
            // Obscures text if required.
            obscureText: widget.obscure,
            // Makes the field read-only if required.
            readOnly: widget.readOnly,
            // Sets the validator function.
            validator: widget.validator,
            // Defines the appearance of the text field.
            decoration: InputDecoration(
              // Sets the hint text based on border style and provided labels.
              hintText: widget.isBorderless
                  ? widget.textLabel
                  : widget.hintText ?? (widget.textLabel != null ? "Insira o(a) ${widget.textLabel!.toLowerCase()}" : null),
              
              // CHANGE 2: Logic for the internal hint/label style.
              // Sets the style for the hint text.
              hintStyle: widget.isBorderless
                  // In borderless mode, the color is the one provided, or a default secondary text color.
                  ? ProjectColorsTheme.appTheme.textTheme.bodyLarge!.copyWith(
                      color: widget.labelColor ?? ProjectColorsTheme.textSecondary,
                    )
                  // In bordered mode, the hint remains a standard grey color.
                  : ProjectColorsTheme.appTheme.textTheme.bodyLarge!.copyWith(
                      color: ProjectColorsTheme.darkGrey,
                    ),

              // Indicates that the text field's background should be filled.
              filled: true,
              // Sets the fill color based on border style and read-only state.
              fillColor: widget.isBorderless
                  ? const Color(0xFFF0F0F0)
                  : (!widget.readOnly ? ProjectColorsTheme.white : widget.disabledColor),
              // Sets the content padding inside the text field.
              contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              // Defines the border when the field is not focused.
              border: widget.isBorderless
                  ? OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)
                  : const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(kRadiusSmall)), borderSide: BorderSide(color: ProjectColorsTheme.lightGrey)),
              // Defines the border when the field is enabled but not focused.
              enabledBorder: widget.isBorderless
                  ? OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)
                  : OutlineInputBorder(borderRadius: BorderRadius.circular(kRadiusMedium), borderSide: const BorderSide(color: ProjectColorsTheme.lightGrey, width: 2)),
              // Defines the border when the field is focused. Null uses the default from the theme.
              focusedBorder: widget.isBorderless
                  ? OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)
                  : null,
              // Ensures the label never floats above the text field.
              floatingLabelBehavior: FloatingLabelBehavior.never,
              // Sets the prefix icon if provided.
              prefixIcon: widget.prefixIcon != null ? IconWidget(widget.prefixIcon!) : null,
              // Resolves the prefix icon color based on the widget's state (e.g., error state).
              prefixIconColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
                if (states.contains(WidgetState.error)) {
                  return ProjectColorsTheme.redColor;
                }
                return ProjectColorsTheme.primaryColor;
              }),
              // Sets the suffix widget if provided.
              suffixIcon: widget.suffixWidget,
              // Controls if the text field is enabled.
              enabled: !widget.readOnly,
              // Sets the maximum lines for an error message.
              errorMaxLines: 2,
            ),
          );
        },
      );
    }

    // A local function that conditionally wraps the text field with a label above it.
    fieldWithLabel(bool condition) {
      // If the condition is true, wrap the text field in a Column with a label.
      if (condition) {
        return Column(
          // Aligns children to the start (left).
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Adds padding below the label.
            Padding(
              padding: const EdgeInsets.only(bottom: kPaddingVerySmall),
              // The label text widget.
              child: TextWidget(
                widget.textLabel.toString(),
                type: TextType.textLarge,
                // CHANGE 3: Using the passed color for the external label.
                style: TextStyle(color: widget.labelColor),
              ),
            ),
            // The text field itself, built by the helper function.
            textFieldBuilder(),
          ],
        );
      } else {
        // If the condition is false, return only the text field.
        return textFieldBuilder();
      }
    }

    // Determines if a label should be shown above the text field.
    final bool showLabelAbove = !widget.isBorderless && widget.useLabel! && widget.textLabel != null;

    // Checks if custom padding is provided for the whole widget.
    if (widget.padding != null) {
      // If so, wrap the field (with or without its label) in a Padding widget.
      return Padding(
        padding: widget.padding!,
        child: fieldWithLabel(showLabelAbove),
      );
    } else {
      // Otherwise, return the field (with or without its label) directly.
      return fieldWithLabel(showLabelAbove);
    }
  }
}