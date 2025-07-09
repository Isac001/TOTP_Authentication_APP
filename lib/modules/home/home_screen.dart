// Import necessary packages from Flutter and project-specific files.
import 'package:flutter/material.dart';
import 'package:totp_authentication_app/utils/project_colors_theme.dart';
import 'package:totp_authentication_app/widgets/basics/text_widget.dart';

/// A widget representing the home screen of the application.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// The state for the HomeScreen.
class _HomeScreenState extends State<HomeScreen> {
  @override
  // Describes the part of the user interface represented by this widget.
  Widget build(BuildContext context) {
    // Returns the basic visual structure for the screen.
    return Scaffold(
      backgroundColor: ProjectColorsTheme.white,
      // The primary content of the scaffold.
      body: (Center(
        // A centered TextWidget displaying the word 'home'.
        child: TextWidget(
          'home',
          style: TextStyle(color: ProjectColorsTheme.mediumGrey),
        ),
      )),
    );
  }
}