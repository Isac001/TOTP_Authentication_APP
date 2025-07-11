import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:totp_authentication_app/auth/services/auth_services.dart';
import 'package:totp_authentication_app/auth/bloc_state_controller/auth_bloc.dart';
import 'package:totp_authentication_app/project_configs/dio/dio_factory.dart';
import 'package:totp_authentication_app/project_configs/storage_secret/secret_storage_repository.dart';

// Creates a global instance of GetIt to use as a service locator.
final sl = GetIt.instance;

// A function to initialize and register all application dependencies.
void initializeDependencies() {
  // Registers SecretRepository as a lazy singleton. It will be created only once when first requested.
  sl.registerLazySingleton(() => SecretRepository());

  // Registers the Dio instance as a lazy singleton, created by the DioFactory.
  sl.registerLazySingleton<Dio>(() => DioFactory.createDio());

  // Registers AuthService as a lazy singleton, injecting the registered Dio instance.
  sl.registerLazySingleton(() => AuthService(dio: sl<Dio>()));

  // Registers AuthBloc as a factory. A new instance will be created every time it is requested.
  sl.registerFactory(() => AuthBloc(
        // Injects the registered AuthService instance.
        authService: sl<AuthService>(),
        // Injects the registered SecretRepository instance.
        secretRepository: sl<SecretRepository>(),
      ));
}