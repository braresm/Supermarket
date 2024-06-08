import 'package:flutter/material.dart';
import 'package:fresh_check/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_screen.dart';
import '../../barcode_scanning.dart';
import '../pages/inventory_check_screen.dart';
import '../../orders_screen.dart';

class CustomDropdownMenu extends StatelessWidget {
  final String employeeName;

  const CustomDropdownMenu({super.key, required this.employeeName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color:
            const Color(0xFF6F8F72), // Adjust this color to match your design
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            employeeName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          _buildMenuItem(
            context,
            Icons.home,
            'Home',
            HomeScreen(),
          ),
          _buildMenuItem(
            context,
            Icons.qr_code,
            'Barcode scanner',
            BarcodeScannerScreen(),
          ),
          _buildMenuItem(
            context,
            Icons.inventory,
            'Inventory check',
            const InventoryCheckScreen(),
          ),
          _buildMenuItem(
            context,
            Icons.shopping_cart,
            'Orders',
            OrdersScreen(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, IconData icon, String title, Widget destination) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
