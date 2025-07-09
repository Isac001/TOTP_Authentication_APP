import 'package:flutter/material.dart';
import 'package:totp_authentication_app/utils/constans_values.dart';

/// Class that holds the global color palette and theme of the application.
class ProjectColorsTheme {
  // Private constructor to prevent instantiation of this class.
  ProjectColorsTheme._();

  // --- MAIN COLORS ---
  static const primaryColor = Color.fromARGB(255, 116, 72, 19);

  // --- BLACK TONES ---
  /// Color for primary texts and titles.
  static const textPrimary = Color(0xFF212121);
  /// Color for secondary texts and elements with less emphasis.
  static const textSecondary = Color(0xFF424242);

  // --- GREY TONES ---
  /// Light grey, ideal for dividers or subtle backgrounds.
  static const lightGrey = Color(0xFFF5F5F5);
  /// Intermediate grey, for helper text or disabled icons.
  static const mediumGrey = Color(0xFF9E9E9E);
  /// Dark grey, for subtitles or low-priority elements.
  static const darkGrey = Color(0xFF616161);

  // --- WHITE TONES ---
  /// White for text and icons on dark backgrounds.
  static const white = Color(0xFFFFFFFF);

  // --- FEEDBACK COLORS ---
  /// Standard red color.
  static const redColor = Color(0xFFFF0000);
  /// A specific shade of red for error snackbars or banners.
  static const errorRed = Color(0xFFD32F2F);

  // --- OTHER COLORS ---
  static const transparentColor = Color(0x00000000);

  /// Static variable that defines the overall visual theme configuration for a MaterialApp.
  static final ThemeData appTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: white,
    dividerColor: lightGrey, // Using the new light grey
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      onPrimary: white, // Using the new white
      secondary: white,
      error: errorRed, // Using the new error color
    ),
    textTheme: _buildTextTheme(),
    filledButtonTheme: _buildFilledButtonTheme(),
    textButtonTheme: _buildTextButtonTheme(),
    iconTheme: _buildIconTheme(),
    appBarTheme: _buildAppBarTheme(),
  );

  /// Builds the application's default TextTheme.
  static TextTheme _buildTextTheme() {
    return const TextTheme(
      titleLarge: TextStyle(
        color: textPrimary,
        fontFamily: 'Sora',
        fontSize: kTitleFontSizeBig,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: textPrimary,
        fontFamily: 'Sora',
        fontSize: kTitleFontSizeMedium,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        color: textSecondary,
        fontFamily: 'Inter',
        fontSize: kBodyFontSizeMedium,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: mediumGrey,
        fontFamily: 'Inter',
        fontSize: kBodyFontSizeSmall,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// Builds the theme for FilledButton widgets.
  static FilledButtonThemeData _buildFilledButtonTheme() {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: white,
        fixedSize: const Size(double.infinity, kButtonHeightMedium),
        elevation: 0,
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

  /// Builds the theme for TextButton widgets.
  static TextButtonThemeData _buildTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: textSecondary,
        backgroundColor: transparentColor,
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(kRadiusMedium)),
        ),
      ),
    );
  }

  /// Builds the default theme for Icon widgets.
  static IconThemeData _buildIconTheme() {
    return const IconThemeData(
      color: textSecondary,
      size: kBodyFontSizeMedium,
    );
  }

  /// Builds the default theme for AppBar widgets.
  static AppBarTheme _buildAppBarTheme() {
    return AppBarTheme(
      backgroundColor: white,
      elevation: 0,
      iconTheme: const IconThemeData(color: textPrimary),
      centerTitle: false,
      titleTextStyle: _buildTextTheme().titleLarge,
    );
  }
}