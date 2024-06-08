abstract class AuthEvent {}

// Define concrete Auth events

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  SignUpEvent(this.email, this.password);
}

class LogoutEvent extends AuthEvent {}
