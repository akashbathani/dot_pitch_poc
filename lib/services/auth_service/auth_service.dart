import '../local_storage_service/shared_preference_service.dart';

class AuthService {
  final SharedPreferenceService _sharedPreferenceService;

  AuthService(this._sharedPreferenceService);

  Future<bool> login(String email, String password, bool rememberMe) async {
    String? storedEmail = _sharedPreferenceService.getString('email');
    String? storedPassword = _sharedPreferenceService.getString('password');

    if (email == storedEmail && password == storedPassword) {
      await _sharedPreferenceService.setBool('isLoggedIn', true);
      await _sharedPreferenceService.setBool('rememberMe', rememberMe);
      return true;
    } else {
      return false;
    }
  }

  Future<void> register(String email, String password) async {
    await _sharedPreferenceService.setBool('isLoggedIn', true);
    await _sharedPreferenceService.setString('email', email);
    await _sharedPreferenceService.setString('password', password);
  }

  bool isLoggedIn()  {
    final isLoggedIn = _sharedPreferenceService.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }
  Future<void> logout() async {
    _sharedPreferenceService.clear();
  }
}
