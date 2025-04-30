import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<String> getToken() async {
    var token = await _secureStorage.read(key: 'token');
    if (token != null) {
      return token;
    } else {
      throw TokenException();
    }
  }

  static Future<void> setToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }
}

class TokenException implements Exception {}
