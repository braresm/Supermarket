import 'package:fresh_check/data/repositories/auth_repository.dart';
import 'package:fresh_check/domain/models/account.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<Account?> call(String email, String password) {
    return repository.signIn(email, password);
  }
}

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Account?> call(String email, String password, String fullname) {
    return repository.signUp(email, password, fullname);
  }
}

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}
