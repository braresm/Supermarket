import 'package:fresh_check/domain/models/account.dart';

class AuthRepository {
  Future<Account?> signIn(String email, String password) async {
    throw UnimplementedError();
  }

  Future<Account?> signUp(String email, String password) async {
    throw UnimplementedError();
  }

  Future<void> signOut() async {
    throw UnimplementedError();
  }
}
