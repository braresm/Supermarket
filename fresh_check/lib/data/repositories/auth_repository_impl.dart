import 'package:fresh_check/data/repositories/auth_repository.dart';
import 'package:fresh_check/domain/models/account.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Account?> signIn(String email, String password) async {
    final response = await Supabase.instance.client.auth
        .signInWithPassword(email: email, password: password);

    return Account(id: response.user!.id, email: response.user!.email);
  }

  @override
  Future<Account?> signUp(String email, String password) async {
    final response = await Supabase.instance.client.auth
        .signUp(email: email, password: password);

    return Account(id: response.user!.id, email: response.user!.email);
  }

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
  }
}
