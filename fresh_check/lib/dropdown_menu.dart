import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'barcode_scanning.dart';
import 'inventory_check_screen.dart';
import 'orders_screen.dart';

class CustomDropdownMenu extends StatelessWidget {
  final String employeeName;

  const CustomDropdownMenu({Key? key, required this.employeeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF6F8F72), // Adjust this color to match your design
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            employeeName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 20),
          _buildMenuItem(context, Icons.home, 'Home', HomeScreen()),
          _buildMenuItem(context, Icons.qr_code, 'Barcode scanner', BarcodeScannerScreen()),
          _buildMenuItem(context, Icons.inventory, 'Inventory check', InventoryCheckScreen()),
          _buildMenuItem(context, Icons.shopping_cart, 'Orders', OrdersScreen()),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add your logout logic here
            },
            child: Text('Log out'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black, backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, Widget destination) {
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
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
