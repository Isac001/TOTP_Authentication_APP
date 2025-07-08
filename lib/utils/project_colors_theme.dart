import 'package:flutter/material.dart';
import 'package:totp_authentication_app/utils/constans_values.dart';

/// Class that holds the global theme of the application.
class ProjectColorsTheme {
  // Create a instance of the theme color class.
  ProjectColorsTheme._();

  // Cores baseadas na imagem fornecida
  static const primaryColor =
      Color.fromARGB(255, 104, 71, 31); // Marrom do botão "Confirmar"
  static const textBlack = Color(0xFF1C1C1C); // Preto dos textos principais
  static const backgroundWhite =
      Color(0xFFF8F6F3); // Branco/Creme do fundo da tela
  static const neutralGrey = Color(0xFFD9D9D9); // Cinza do teclado e bordas
  static const whiteColor =
      Color(0xFFFFFFFF); // Branco puro para texto em botões, etc.
  static const transparentColor = Color(0x00000000);
  static const redColor = Color(0xFFFF0000);

  /// Static variable to define the configuration of the overall visual Theme for a MaterialApp
  static final ThemeData appTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: backgroundWhite,
    dividerColor: neutralGrey,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      onPrimary: whiteColor,
      secondary: whiteColor,
      background: backgroundWhite,
      error: Colors.red, // Cor de erro padrão
    ),
    textTheme: _buildTextTheme(),
    // Usaremos um tema geral de botão preenchido para o botão principal
    filledButtonTheme: _buildFilledButtonTheme(),
    textButtonTheme: _buildTextButtonTheme(),
    iconTheme: _buildIconTheme(),
    appBarTheme: _buildAppBarTheme(),
  );

  /// Sets the text theme.
  static TextTheme _buildTextTheme() {
    return const TextTheme(
      titleLarge: TextStyle(
        color: textBlack,
        fontFamily: 'Sora',
        fontSize: kTitleFontSizeBig,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: textBlack,
        fontFamily: 'Sora',
        fontSize: kTitleFontSizeMedium,
        fontWeight: FontWeight.w500,
      ),
      // Subtítulo "Insira o código que foi enviado:"
      bodyMedium: TextStyle(
        color: textBlack,
        fontFamily: 'Inter',
        fontSize: kBodyFontSizeMedium,
        fontWeight: FontWeight.w400,
      ),
      // Texto "Não recebi o código"
      bodySmall: TextStyle(
        color: textBlack,
        fontFamily: 'Inter',
        fontSize: kBodyFontSizeSmall,
        fontWeight: FontWeight.w500, // Um pouco mais de peso
      ),
    );
  }

  /// Define o tema para botões preenchidos, como o "Confirmar"
  static FilledButtonThemeData _buildFilledButtonTheme() {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: primaryColor, // Cor do botão
        foregroundColor: whiteColor, // Cor do texto do botão
        fixedSize: const Size(double.infinity, kButtonHeightMedium),
        elevation: 0, // Sem sombra, como na imagem
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(kRadiusMedium)),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: kBodyFontSizeMedium,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Define o tema para botões de texto, como o "Não recebi o código"
  static TextButtonThemeData _buildTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: textBlack, // Cor do texto
        backgroundColor: transparentColor,
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(kRadiusMedium)),
        ),
      ),
    );
  }

  /// Sets the icon theme.
  static IconThemeData _buildIconTheme() {
    return const IconThemeData(
      color: textBlack, // Ícones serão pretos por padrão
      size: kBodyFontSizeMedium,
    );
  }

  /// Sets the app bar theme.
  static AppBarTheme _buildAppBarTheme() {
    return AppBarTheme(
      backgroundColor: backgroundWhite, // Fundo da appbar igual ao da tela
      elevation: 0, // Sem sombra
      iconTheme: const IconThemeData(color: textBlack), // Ícone de voltar preto
      centerTitle: false, // Título alinhado à esquerda na maioria dos casos
      titleTextStyle: _buildTextTheme().titleLarge,
    );
  }
}
