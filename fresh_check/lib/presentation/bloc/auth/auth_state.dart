import 'package:fresh_check/domain/models/account.dart';

abstract class AuthState {}

// Define concrete Auth states
class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Account account;

  AuthSuccess(this.account);
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}
