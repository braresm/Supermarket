import 'package:flutter/material.dart';
import 'get_started_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GetStartedScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
    );
  }
}
