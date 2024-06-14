import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_check/presentation/bloc/auth/auth_bloc.dart';
import 'package:fresh_check/presentation/bloc/auth/auth_event.dart';
import 'package:fresh_check/presentation/bloc/auth/auth_state.dart';
import 'package:fresh_check/presentation/pages/home_screen.dart';
import 'get_started_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    // Dispatch AppStartedEvent event to trigger authentication check
    BlocProvider.of<AuthBloc>(context).add(AppStartedEvent());

    Future.delayed(Duration(seconds: 5), () {
      // Navigation logic will be handled in BlocListener
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (state is AuthInitial) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const GetStartedScreen()),
            );
          }
        },
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fontSizeWelcome = constraints.maxWidth * 0.08;
              double fontSizeFreshCheck = constraints.maxWidth * 0.1;

              return Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Welcome to\n',
                    style: TextStyle(
                      fontSize: fontSizeWelcome,
                      color: Color(0xFF77AD78),
                    ),
                    children: [
                      TextSpan(
                        text: 'Fresh Check',
                        style: TextStyle(
                          fontSize: fontSizeFreshCheck,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF77AD78),
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
