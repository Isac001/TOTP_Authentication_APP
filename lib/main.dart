import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totp_authentication_app/auth/bloc_state_controller/auth_bloc.dart';
import 'package:totp_authentication_app/auth/bloc_state_controller/auth_events.dart';
import 'package:totp_authentication_app/project_configs/routes/app_routes.dart';
import 'package:totp_authentication_app/project_configs/dependency/dependency_injector.dart';


// The main entry point of the application.
void main() {
  // Initializes all registered dependencies using GetIt.
  initializeDependencies();
  // Runs the root widget of the application.
  runApp(const TOPTAuthProject());
}

// The root widget of the application.
class TOPTAuthProject extends StatelessWidget {
  // Constant constructor for the root widget.
  const TOPTAuthProject({super.key});

  // Describes the part of the user interface represented by this widget.
  @override
  // The build method returns the widget tree.
  Widget build(BuildContext context) {
    // Provides an instance of AuthBloc to its descendant widgets.
    return BlocProvider(
      // Creates the AuthBloc instance using the service locator and dispatches the initial event.
      create: (context) => sl<AuthBloc>()..add(AuthAppStarted()),
      // The child widget that will have access to the AuthBloc.
      child: MaterialApp(
        // The title of the application.
        title: 'TOTP Auth App',
         // Hides the debug banner in the top-right corner.
         debugShowCheckedModeBanner: false,
        
        // Sets the initial route of the app using a constant from AppRoutes.
        initialRoute: AppRoutes.authWrapper,

        // Assigns the entire route map from the AppRoutes class.
        routes: AppRoutes.all,
      ),
    );
  }
}