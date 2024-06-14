import 'package:flutter/material.dart';
import 'presentation/widgets/custom_scaffold.dart';
import 'chat_screen.dart'; // Import the ChatScreen

class AssistantScreen extends StatelessWidget {
  final String employeeName;

  const AssistantScreen({super.key, required this.employeeName});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      employeeName: 'Employee Name',
      body: ChatScreen(
        employeeName: employeeName,
      ),
      customColor: Color(0xFF6F8F72),
      title: 'Assistant Screen',
    );
  }
}
