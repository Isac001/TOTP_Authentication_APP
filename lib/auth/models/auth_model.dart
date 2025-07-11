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
    // Requires the username parameter.
    required this.username,
    // Requires the password parameter.
    required this.password,
    // Requires the totpCode parameter.
    required this.totpCode,
  });

  // Method to convert the object into a JSON-compatible Map.
  Map<String, dynamic> toJson() {
    // Returns a Map with keys matching the API's expected format.
    return {
      // Maps the username property to the 'username' key.
      'username': username,
      // Maps the password property to the 'password' key.
      'password': password,
      // Maps the totpCode property to the 'totp_code' key.
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
    // Requires the username parameter.
    required this.username,
    // Requires the password parameter.
    required this.password,
    // Requires the code parameter.
    required this.code,
  });

  // Method to convert the object into a JSON-compatible Map.
  Map<String, dynamic> toJson() {
    // Returns a Map with keys matching the API's expected format.
    return {
      // Maps the username property to the 'username' key.
      'username': username,
      // Maps the password property to the 'password' key.
      'password': password,
      // Maps the code property to the 'code' key.
      'code': code,
    };
  }
}