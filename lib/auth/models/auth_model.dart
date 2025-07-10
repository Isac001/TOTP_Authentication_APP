// lib/auth/models/auth_request_models.dart

/// Model que representa os dados para a requisição de login.
class LoginRequestModel {
  // Campos finais para garantir que os dados não sejam nulos ou alterados após a criação.
  final String username;
  final String password;
  final String totpCode;

  // Construtor que exige todos os campos necessários.
  const LoginRequestModel({
    required this.username,
    required this.password,
    required this.totpCode,
  });

  /// Método para converter o objeto em um Map no formato JSON que a API espera.
  /// As chaves do Map ('username', 'password', 'totp_code') devem ser
  /// exatamente iguais às que o backend espera.
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'totp_code': totpCode,
    };
  }
}

/// Model que representa os dados para a requisição de recuperação de secret.
class RecoverSecretRequestModel {
  final String username;
  final String password;
  final String code;

  // Construtor que exige todos os campos.
  const RecoverSecretRequestModel({
    required this.username,
    required this.password,
    required this.code,
  });

  /// Método para converter o objeto para o formato JSON esperado pela API.
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'code': code,
    };
  }
}