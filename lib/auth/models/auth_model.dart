// Model representing the data for a login request.
class LoginRequestModel {
  
  // Final field for the username.
  final String username;
  // Final field for the password.
  final String password;
  // Final field for the Time-based One-Time Password code.
  final String totpCode;

  // Constant constructor requiring all fields.
  const LoginRequestModel({
    required this.username,
    required this.password,
    required this.totpCode,
  });

  // Method to convert the object into a JSON-compatible Map.
  Map<String, dynamic> toJson() {
    // Returns a Map with keys matching the API's expected format.
    return {
      'username': username,
      'password': password,
      'totp_code': totpCode,
    };
  }
}

// Model representing the data for a secret recovery request.
class RecoverSecretRequestModel {
  // Final field for the username.
  final String username;
  // Final field for the password.
  final String password;
  // Final field for the special recovery code.
  final String code;

  // Constant constructor requiring all fields.
  const RecoverSecretRequestModel({
    required this.username,
    required this.password,
    required this.code,
  });

  // Method to convert the object into a JSON-compatible Map.
  Map<String, dynamic> toJson() {
    // Returns a Map with keys matching the API's expected format.
    return {
      'username': username,
      'password': password,
      'code': code,
    };
  }
}