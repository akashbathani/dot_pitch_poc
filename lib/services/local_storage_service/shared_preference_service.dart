import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static final SharedPreferenceService _instance = SharedPreferenceService._internal();
  SharedPreferences? _preferences;

  factory SharedPreferenceService() {
    return _instance;
  }

  SharedPreferenceService._internal();

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  SharedPreferences? get preferences => _preferences;

  // Function to set a string value
  Future<void> setString(String key, String value) async {
    if (_preferences != null) {
      await _preferences!.setString(key, value);
    }
  }

  // Function to get a string value
  String? getString(String key) {
    return _preferences?.getString(key);
  }
  Future<void> clearCredentials() async {
    await remove('email');
    await remove('password');
  }
  // Function to set a boolean value
  Future<void> setBool(String key, bool value) async {
    if (_preferences != null) {
      await _preferences!.setBool(key, value);
    }
  }

  // Function to get a boolean value
  bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  // Function to remove a specific key
  Future<void> remove(String key) async {
    if (_preferences != null) {
      await _preferences!.remove(key);
    }
  }

  // Function to clear all data
  Future<void> clear() async {
    if (_preferences != null) {
      await _preferences!.clear();
    }
  }
  Future<void> setRememberMe(bool value) async {
    await setBool('rememberMe', value);
  }

  bool getRememberMe() {
    return getBool('rememberMe') ?? false;
  }
  String? getEmail() {
    return getString('email');
  }

  String? getPassword() {
    return getString('password');
  }
  Future<void> saveCredentials(String email, String password) async {
    await setString('email', email);
    await setString('password', password);
  }
}
