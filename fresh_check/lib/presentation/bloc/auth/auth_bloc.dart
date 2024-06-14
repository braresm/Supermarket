import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_check/domain/usecases/auth_usecase.dart';
import 'package:fresh_check/presentation/bloc/auth/auth_event.dart';
import 'package:fresh_check/presentation/bloc/auth/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<AppStartedEvent>(_onAppStarted);
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onAppStarted(
      AppStartedEvent event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');

    if (email != null && password != null) {
      try {
        final account = await signInUseCase(email, password);

        emit(AuthSuccess(account!));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final account = await signInUseCase(event.email, event.password);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', event.email);
      await prefs.setString('password', event.password);

      emit(AuthSuccess(account!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final account =
          await signUpUseCase(event.email, event.password, event.fullname);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', event.email);
      await prefs.setString('password', event.password);

      emit(AuthSuccess(account!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await logoutUseCase();

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('email');
      await prefs.remove('password');

      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
