import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static late SharedPreferences _storage;

  static Future<void> initialize() async {
    _storage = await SharedPreferences.getInstance();
  }

  static String? get getToken {
    if (_storage.containsKey('Token') == false) {
      return null;
    }
    return _storage.getString('Token');
  }

  static bool hasToken() => _storage.containsKey('Token');

  static Future<void> setTokens({
    required String token,
  }) async {
    await _storage.setString('Token', token);
  }

  static Future<bool> logout() {
    return _storage.clear();
  }
}
