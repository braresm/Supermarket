import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  Future<User?> signIn(String email, String password) async {
    final response = await Supabase.instance.client.auth
        .signInWithPassword(email: email, password: password);
    return response.user;
  }

  Future<User?> signUp(String email, String password) async {
    final response = await Supabase.instance.client.auth
        .signUp(email: email, password: password);
    return response.user;
  }

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
  }
}
