import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

// Caminhos Corrigidos baseados na sua estrutura
import 'package:totp_authentication_app/auth/services/auth_services.dart';
import 'package:totp_authentication_app/auth/bloc/auth_bloc.dart';
import 'package:totp_authentication_app/project_configs/dio/dio_factory.dart';
import 'package:totp_authentication_app/project_configs/secret/secret_repository.dart';

final sl = GetIt.instance;

void initializeDependencies() {
  // --- Repositórios ---
  sl.registerLazySingleton(() => SecretRepository());

  // --- Rede (Network) ---
  sl.registerLazySingleton<Dio>(() => DioFactory.createDio());

  // --- Serviços ---
  sl.registerLazySingleton(() => AuthService(dio: sl<Dio>()));

  // --- BLoCs ---
  sl.registerFactory(() => AuthBloc(
        authService: sl<AuthService>(),
        secretRepository: sl<SecretRepository>(),
      ));
}