import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fresh_check/data/repositories/auth_repository.dart';
import 'package:fresh_check/domain/usecases/auth_usecase.dart';
import 'package:fresh_check/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load the .env file contents into dotenv.
  await dotenv.load(fileName: ".env");

  // create connection to Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const FreshCheckApp());
}

class FreshCheckApp extends StatelessWidget {
  const FreshCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(
            signInUseCase: SignInUseCase(AuthRepository()),
            signUpUseCase: SignUpUseCase(AuthRepository()),
            logoutUseCase: LogoutUseCase(AuthRepository()),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fresh Check',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}
