import 'package:bloc/bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../services/auth_service/auth_service.dart';
import '../../services/local_storage_service/shared_preference_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final SharedPreferenceService _prefs;

  AuthBloc(this._authService, this._prefs) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      bool success = await _authService.login(event.email, event.password, event.rememberMe);

      if (success) {
        if (event.rememberMe) {
          await _prefs.saveCredentials(event.email, event.password);
        } else {
          await _prefs.clearCredentials();
        }

        await _prefs.setRememberMe(event.rememberMe);
        emit(AuthLoginSuccess());
      }
      else {
        emit(AuthFailure("Invalid credentials"));
      }
    } catch (e) {
      emit(AuthFailure("An error occurred during login"));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await _authService.register(event.email, event.password);
      emit(AuthRegisterSuccess());
    } catch (e) {
      emit(AuthFailure("An error occurred during registration"));
    }
  }
}
