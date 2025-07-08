import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:totp_authentication_app/utils/constans_values.dart'; // Usando seus valores
import 'package:totp_authentication_app/utils/project_colors_theme.dart'; // Usando suas cores

class CodeTOTPFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final int numberOfFields;
  final Function(String)? onCompleted;

  const CodeTOTPFieldWidget({
    super.key,
    required this.controller,
    this.numberOfFields = 6,
    this.onCompleted,
  });

  @override
  State<CodeTOTPFieldWidget> createState() => _CodeTOTPFieldWidgetState();
}

class _CodeTOTPFieldWidgetState extends State<CodeTOTPFieldWidget> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Adiciona um listener para atualizar a UI sempre que o texto mudar
    widget.controller.addListener(() {
      setState(() {});
    });
    // Adiciona um listener para o foco para garantir que o cursor esteja no lugar certo
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // Move o cursor para o final do texto quando o campo ganha foco
        widget.controller.selection = TextSelection.fromPosition(
          TextPosition(offset: widget.controller.text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    // Limpa os recursos para evitar vazamento de memória
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Solicita o foco para o TextField oculto para abrir o teclado
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: Stack(
        children: [
          // 1. As caixas de exibição visuais
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.numberOfFields, (index) {
              return _buildOtpBox(index);
            }),
          ),
          // 2. O TextField oculto que captura a entrada
          _buildHiddenTextField(),
        ],
      ),
    );
  }

  /// Constrói o TextField que fica invisível mas captura os eventos do teclado.
  Widget _buildHiddenTextField() {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.number,
      // Limita o tamanho do código
      maxLength: widget.numberOfFields,
      // Formata para aceitar apenas dígitos
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      // Executa a função de callback quando o código é preenchido
      onChanged: (value) {
        if (value.length == widget.numberOfFields) {
          widget.onCompleted?.call(value);
          _focusNode.unfocus(); // Esconde o teclado
        }
        setState(() {});
      },
      // Torna o TextField efetivamente invisível
      decoration: const InputDecoration(
        border: InputBorder.none,
        counterText: '', // Remove o contador de caracteres
      ),
      // Esconde o cursor
      cursorColor: Colors.transparent,
      // Esconde o texto digitado
      style: const TextStyle(color: Colors.transparent, height: 0.01),
    );
  }

  /// Constrói cada caixa individual que exibe um dígito do código.
  Widget _buildOtpBox(int index) {
    final text = widget.controller.text;
    final isCurrent = index == text.length;
    final hasValue = index < text.length;

    return Container(
      width: 50,
      height: 60,
      decoration: BoxDecoration(
        color: ProjectColorsTheme.backgroundWhite,
        borderRadius: BorderRadius.circular(kRadiusMedium), // Usando seu valor de raio
        border: Border.all(
          // O estilo da borda muda se a caixa está selecionada
          color: isCurrent ? ProjectColorsTheme.primaryColor : ProjectColorsTheme.neutralGrey,
          width: 2,
        ),
      ),
      child: Center(
        child: hasValue
            ? Text(
                text[index],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ProjectColorsTheme.textBlack, // Cor do seu tema
                ),
              )
            // Simula o cursor piscando na caixa atual
            : isCurrent
                ? _BlinkingCursor()
                : const SizedBox.shrink(),
      ),
    );
  }
}

// Widget auxiliar para criar o efeito de cursor piscando
class _BlinkingCursor extends StatefulWidget {
  @override
  _BlinkingCursorState createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 2,
        height: 24,
        color: ProjectColorsTheme.primaryColor,
      ),
    );
  }
}