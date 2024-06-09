import 'package:fresh_check/data/repositories/auth_repository.dart';
import 'package:fresh_check/domain/models/account.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bcrypt/bcrypt.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Account?> signIn(String email, String password) async {
    final response = await Supabase.instance.client.auth
        .signInWithPassword(email: email, password: password);

    final user = response.user;

    if (user == null) {
      return null;
    }

    // Get the account details from the users table based on the email
    final accountResponse = await Supabase.instance.client
        .from('users')
        .select()
        .eq('email', user.email!)
        .single();

    print(accountResponse);

    return Account(
      id: response.user!.id,
      email: response.user!.email,
      fullname: accountResponse['full_name'],
    );
  }

  @override
  Future<Account?> signUp(
      String email, String password, String fullname) async {
    final response = await Supabase.instance.client.auth
        .signUp(email: email, password: password);

    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

    // Insert the user details to the users table
    await Supabase.instance.client.from('users').insert({
      'username': response.user!.email,
      'full_name': fullname,
      'role': 'manager',
      'email': response.user!.email,
      'password_hash': hashedPassword,
    });

    return Account(
      id: response.user!.id,
      email: response.user!.email,
      fullname: fullname,
    );
  }

  @override
  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
  }
}
