



import 'package:dio/dio.dart';
import 'package:totp_authentication_app/auth/models/auth_model.dart';
// 1. Importamos os models que definem os dados da requisição

class AuthService {
  final Dio _dio;

  AuthService({required Dio dio}) : _dio = dio;

  static const String _loginEndpoint = '/auth/login';
  static const String _recoverySecretEndpoint = '/auth/recovery-secret';

  // 2. O método agora recebe um único objeto fortemente tipado
  Future<String> recoverSecret({
    required RecoverSecretRequestModel recoveryRequest,
  }) async {
    try {
      final response = await _dio.post(
        _recoverySecretEndpoint,
        // 3. O corpo da requisição é gerado pelo método .toJson() do model
        data: recoveryRequest.toJson(),
      );
      
      final secret = response.data['totp_secret'] as String?;
      if (secret != null && secret.isNotEmpty) {
        return secret;
      } else {
        throw Exception('API retornou sucesso, mas o secret está ausente na resposta.');
      }
    } on DioException catch (e) {
      throw Exception('Falha ao recuperar o secret: ${e.response?.data}');
    }
  }

  // 2. O método de login também foi atualizado para receber seu respectivo model
  Future<void> login({
    required LoginRequestModel loginRequest,
  }) async {
    try {
      await _dio.post(
        _loginEndpoint,
        // 3. Usamos o .toJson() do LoginRequestModel aqui
        data: loginRequest.toJson(),
      );
    } on DioException catch (e) {
      throw Exception('Falha no login: ${e.response?.data}');
    }
  }
}