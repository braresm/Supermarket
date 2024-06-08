import 'package:flutter/material.dart';
import '../widgets/custom_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      employeeName: 'Employee Name',
      body: Center(
        child: Text('Home Screen'),
      ),
      customColor: Color(0xFF6F8F72),
      title: 'Home',
      showBackArrow: false,
    );
  }
}
