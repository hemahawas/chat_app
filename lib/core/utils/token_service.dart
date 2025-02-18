import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static final FlutterSecureStorage _secureStorage =
      const FlutterSecureStorage();

  static Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }

  static Future<void> setToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }
}
