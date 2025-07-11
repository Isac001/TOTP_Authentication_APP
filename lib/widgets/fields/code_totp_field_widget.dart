// Import necessary packages from Flutter.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:totp_authentication_app/utils/constans_values.dart'; // Using your values
import 'package:totp_authentication_app/utils/project_colors_theme.dart'; // Using your colors

/// This [CodeTOTPFieldWidget] is a custom widget for inputting Time-based One-Time Passwords (TOTP).
/// It displays a series of boxes but uses a single hidden TextField for input.
class CodeTOTPFieldWidget extends StatefulWidget {
  // Controller to manage the text input.
  final TextEditingController controller;
  // The number of fields to display for the code. Defaults to 6.
  final int numberOfFields;
  // An optional callback function that is triggered when the code is completely filled.
  final Function(String)? onCompleted;
  // ▼▼▼ 1. PROPRIEDADE ADICIONADA ▼▼▼
  // An optional callback function that is triggered every time the input changes.
  final Function(String)? onChanged;

  // Constructor for the CodeTOTPFieldWidget.
  const CodeTOTPFieldWidget({
    super.key,
    required this.controller,
    this.numberOfFields = 6,
    this.onCompleted,
    this.onChanged, // Adicionado ao construtor
  });

  @override
  // Creates the mutable state for this widget.
  State<CodeTOTPFieldWidget> createState() => _CodeTOTPFieldWidgetState();
}

// The state class for CodeTOTPFieldWidget, containing the logic and UI.
class _CodeTOTPFieldWidgetState extends State<CodeTOTPFieldWidget> {
  // A FocusNode to control the focus of the hidden TextField.
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Adds a listener to the controller to rebuild the UI whenever the text changes.
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    // Adds a listener to the focus node to manage the cursor position.
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // Moves the cursor to the end of the text when the field gains focus.
        widget.controller.selection = TextSelection.fromPosition(
          TextPosition(offset: widget.controller.text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    // Cleans up the focus node to prevent memory leaks.
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // A GestureDetector wraps the widget to request focus when tapped.
    return GestureDetector(
      onTap: () {
        // Requests focus for the hidden TextField to open the keyboard.
        FocusScope.of(context).requestFocus(_focusNode);
      },
      // A Stack is used to overlay the hidden TextField on top of the visible boxes.
      child: Stack(
        children: [
          // 1. The visual display boxes for the OTP code.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.numberOfFields, (index) {
              return _buildOtpBox(index);
            }),
          ),
          // 2. The hidden TextField that captures the actual input.
          _buildHiddenTextField(),
        ],
      ),
    );
  }

  /// Builds the TextField that remains invisible but captures keyboard events.
  Widget _buildHiddenTextField() {
    return TextField(
      // Assigns the controller and focus node.
      controller: widget.controller,
      focusNode: _focusNode,
      // Sets the keyboard to show numbers only.
      keyboardType: TextInputType.number,
      // Limits the input length to the number of fields.
      maxLength: widget.numberOfFields,
      // Formats the input to accept only digits.
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      // Callback triggered when the input value changes.
      onChanged: (value) {
        // ▼▼▼ 2. CALLBACK SENDO CHAMADO ▼▼▼
        // Notifica o widget pai sobre a mudança no valor.
        widget.onChanged?.call(value);
        // ▲▲▲ FIM DA MUDANÇA ▲▲▲

        // Quando o código é totalmente preenchido, aciona o onCompleted.
        if (value.length == widget.numberOfFields) {
          widget.onCompleted?.call(value);
          _focusNode.unfocus(); // Hides the keyboard.
        } else {
          // Rebuild the widget to update the visual boxes on every change.
          // O listener no initState já cuida disso, mas um setState aqui garante a atualização.
          setState(() {});
        }
      },
      // Makes the TextField effectively invisible.
      decoration: const InputDecoration(
        // Hides the border.
        border: InputBorder.none,
        // Removes the character counter.
        counterText: '',
      ),
      // Hides the cursor from view.
      cursorColor: Colors.transparent,
      // Hides the typed text by making it transparent and giving it a near-zero height.
      style: const TextStyle(color: Colors.transparent, height: 0.01),
    );
  }

  /// Builds each individual box that displays a digit of the code.
  Widget _buildOtpBox(int index) {
    // The current text in the controller.
    final text = widget.controller.text;
    // True if this box is the current one to be filled.
    final isCurrent = index == text.length;
    // True if this box already has a digit.
    final hasValue = index < text.length;

    return Container(
      width: 50,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0), // Cor de fundo mais clara
        // Using your border radius constant.
        borderRadius: BorderRadius.circular(kRadiusMedium),
        border: Border.all(
          // The border style changes if the box is currently selected.
          color: isCurrent
              ? ProjectColorsTheme.primaryColor
              : Colors.grey.shade400, // Cor da borda mais sutil
          width: 1.5,
        ),
      ),
      // Centers the content within the box.
      child: Center(
        child: hasValue
            // If the box has a value, display the digit.
            ? Text(
                text[index],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // Using your primary text color.
                  color: ProjectColorsTheme.textPrimary,
                ),
              )
            // If the box is the current input position, show a blinking cursor.
            : isCurrent
                ? _BlinkingCursor()
                // Otherwise, show an empty box.
                : const SizedBox.shrink(),
      ),
    );
  }
}

// A helper widget to create the blinking cursor effect.
class _BlinkingCursor extends StatefulWidget {
  @override
  _BlinkingCursorState createState() => _BlinkingCursorState();
}

// The state for the _BlinkingCursor widget, managing the animation.
class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  // The controller that manages the animation.
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Initializes the animation controller.
    _controller = AnimationController(
      // Provides the Ticker provider.
      vsync: this,
      // Sets the duration of one fade cycle.
      duration: const Duration(milliseconds: 500),
      // Makes the animation repeat indefinitely.
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    // Disposes of the controller to free up resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // A FadeTransition widget animates the opacity of its child.
    return FadeTransition(
      opacity: _controller,
      // The visual representation of the cursor.
      child: Container(
        width: 2,
        height: 24,
        color: ProjectColorsTheme.primaryColor,
      ),
    );
  }
}