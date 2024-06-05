import 'package:flutter/material.dart';
import 'welcome_screen.dart';

void main() {
  runApp(FreshCheckApp());
}

class FreshCheckApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fresh Check',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: WelcomeScreen(),

    );
  }
}
