import 'package:dio/dio.dart';
import 'package:totp_authentication_app/auth/models/auth_model.dart';

// A service class responsible for handling authentication API calls.
class AuthService {

  // A final private property to hold the Dio instance.
  final Dio _dio;

  // Constructor that injects a Dio instance.
  AuthService({required Dio dio}) : _dio = dio;

  // Defines the endpoints for the login API.
  static const String _loginEndpoint = '/auth/login';
  static const String _recoverySecretEndpoint = '/auth/recovery-secret';

  // Asynchronous method to recover the TOTP secret from the API.
  Future<String> recoverSecret({
    // Requires a strongly-typed model for the recovery request.
    required RecoverSecretRequestModel recoveryRequest,
  // Marks the method as asynchronous.
  }) async {
    // Starts a try block to handle potential errors during the API call.
    try {
      // Awaits the response from the POST request to the recovery endpoint.
      final response = await _dio.post(
        // Uses the defined endpoint for secret recovery.
        _recoverySecretEndpoint,
        // Serializes the request model object to JSON for the request body.
        data: recoveryRequest.toJson(),
      );
      
      // Extracts the 'totp_secret' from the response data, casting it as a nullable String.
      final secret = response.data['totp_secret'] as String?;
      // Checks if the extracted secret is not null and not empty.
      if (secret != null && secret.isNotEmpty) {
        // Returns the valid secret if the check passes.
        return secret;
      // If the secret is null or empty, this block is executed.
      } else {
        // Throws an exception indicating the API response was successful but lacked the secret.
        throw Exception('API retornou sucesso, mas o secret está ausente na resposta.');
      }
    // Catches exceptions specific to the Dio package (e.g., network errors, 4xx/5xx status codes).
    } on DioException catch (e) {
      // Throws a new, more descriptive exception including the server's response data.
      throw Exception('Falha ao recuperar o secret: ${e.response?.data}');
    }
  }

  // Asynchronous method to perform user login.
  Future<void> login({
    // Requires a strongly-typed model for the login request.
    required LoginRequestModel loginRequest,
  // Marks the method as asynchronous.
  }) async {
    // Starts a try block for error handling.
    try {
      // Awaits the completion of the POST request to the login endpoint.
      await _dio.post(
        // Uses the defined endpoint for login.
        _loginEndpoint,
        // Serializes the login request model to JSON for the request body.
        data: loginRequest.toJson(),
      );
    // Catches exceptions specific to the Dio package.
    } on DioException catch (e) {
      // Throws a new, more descriptive exception for login failure.
      throw Exception('Falha no login: ${e.response?.data}');
    }
  }
}