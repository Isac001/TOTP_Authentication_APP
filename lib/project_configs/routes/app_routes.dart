import 'package:flutter/material.dart';
import 'package:totp_authentication_app/auth/wrapper/auth_wrapper.dart';
import 'package:totp_authentication_app/screens/home/home_screen.dart';
import 'package:totp_authentication_app/screens/login/login_screen.dart';
import 'package:totp_authentication_app/screens/topt_code/topt_code_validation_screen.dart';

// A class that centralizes the application's route management.
class AppRoutes {

  // Defines the root route, pointing to the authentication wrapper.
  static const String authWrapper = '/';
  // Defines the route name for the login screen.
  static const String login = '/login';
  // Defines the route name for the recovery screen.
  static const String recovery = '/recovery';
  // Defines the route name for the home screen.
  static const String home = '/home';

  // A static getter that returns the complete map of app routes.
  static Map<String, WidgetBuilder> get all {
    // Returns a map where each route name is associated with a widget builder.
    return {
      authWrapper: (context) => const AuthWrapper(),
      login: (context) => const LoginScreen(),
      recovery: (context) => const TOPTCodeValidationScreen(),
      home: (context) => const HomeScreen(),
    };
  }
}