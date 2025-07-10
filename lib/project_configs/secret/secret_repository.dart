import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Usando a versão segura

class SecretRepository {
  final _storage = FlutterSecureStorage();
  static const _secretKey = 'totp_secret';

  // O único dado que precisamos persistir é o secret do TOTP
  Future<String?> getSecret() async {
    return await _storage.read(key: _secretKey);
  }

  Future<void> saveSecret(String secret) async {
    await _storage.write(key: _secretKey, value: secret);
  }

  Future<void> deleteSecret() async {
    await _storage.delete(key: _secretKey);
  }
}