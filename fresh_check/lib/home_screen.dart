import 'package:flutter/material.dart';
import 'custom_scaffold.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      employeeName: 'Employee Name',
      body: Center(
        child: Text('Home Screen'),
      ),
      customColor: Color(0xFF6F8F72),
      title: 'Home',
      showBackArrow:false,
    );
  }
}
