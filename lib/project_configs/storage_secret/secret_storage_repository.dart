// Imports the flutter_secure_storage package for secure data persistence.
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// A repository class to manage storing and retrieving the TOTP secret securely.
class SecretRepository {
  // Creates an instance of FlutterSecureStorage to interact with secure storage.
  final _storage = FlutterSecureStorage();
  // Defines a constant key for storing and retrieving the secret.
  static const _secretKey = 'totp_secret';

  // Asynchronously retrieves the stored TOTP secret.
  Future<String?> getSecret() async {
    // Reads the value associated with the secret key from secure storage.
    return await _storage.read(key: _secretKey);
  }

  // Asynchronously saves the TOTP secret to secure storage.
  Future<void> saveSecret(String secret) async {
    // Writes the provided secret to secure storage using the defined key.
    await _storage.write(key: _secretKey, value: secret);
  }

  // Asynchronously deletes the TOTP secret from secure storage.
  Future<void> deleteSecret() async {
    // Deletes the value associated with the secret key from secure storage.
    await _storage.delete(key: _secretKey);
  }
}