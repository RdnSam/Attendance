import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  static final _storage = const FlutterSecureStorage();

  static Future<String?> getRole() async {
    return await _storage.read(key: 'role');
  }

  static Future<String?> getUserId() async {
    return await _storage.read(key: 'userId');
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  static Future<void> logout() async {
    await _storage.deleteAll();
  }
}
