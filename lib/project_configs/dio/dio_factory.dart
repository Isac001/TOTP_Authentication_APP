import 'package:dio/dio.dart';
import 'package:totp_authentication_app/project_configs/interceptos/custom_inteceptors.dart';

// A factory class for creating pre-configured Dio instances.
class DioFactory {
  // A static method to create and configure a Dio instance.
  static Dio createDio() { 
    // Reads the base URL from an environment variable named 'BASEURL'.
    const String baseUrlFromEnv = String.fromEnvironment(
      // The name of the environment variable to read.
      'BASEURL',
    );

    // Creates a new Dio instance with base options.
    final dio = Dio(
      // Configuration options for the Dio instance.
      BaseOptions(
        // Sets the base URL for all requests, read from the environment.
        baseUrl: baseUrlFromEnv, 
        // Sets the connection timeout duration.
        connectTimeout: const Duration(seconds: 15),
        // Sets the receive timeout duration.
        receiveTimeout: const Duration(seconds: 15),
        // Sets the default headers for all requests.
        headers: {
          // Sets the content type to JSON.
          'Content-Type': 'application/json',
          // Sets the accepted response type to JSON.
          'Accept': 'application/json',
        },
      ),
    );

    // Adds custom interceptors to the Dio instance.
    dio.interceptors.add(CustomInterceptors());

    // Returns the fully configured Dio instance.
    return dio;
  }
}