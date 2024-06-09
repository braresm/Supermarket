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
  final String fullname;

  SignUpEvent(this.email, this.password, this.fullname);
}

class LogoutEvent extends AuthEvent {}
