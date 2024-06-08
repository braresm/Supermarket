import 'package:flutter/material.dart';

import 'presentation/widgets/custom_scaffold.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      employeeName: 'Employee Name',
      body: Center(
        child: Text('Orders Screen'),
      ),
      customColor: Color(0xFF6F8F72),
      title: 'Orders Screen',
    );
  }
}
