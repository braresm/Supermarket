import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_check/presentation/widgets/custom_scaffold.dart';
import 'package:fresh_check/data/repositories/product_repository_impl.dart';
import 'package:fresh_check/domain/usecases/get_product_inventory_by_barcode_usecase.dart';
import 'package:fresh_check/fresh_check_screen.dart';

import 'package:fresh_check/presentation/bloc/product_inventory/product_inventory_bloc.dart';
import 'package:fresh_check/presentation/pages/add_new_item_screen.dart';
import 'package:fresh_check/presentation/pages/counting_screen.dart';
import 'package:fresh_check/reordering_screen.dart';

class InventoryCheckScreen extends StatelessWidget {
  const InventoryCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      employeeName: 'Employee Name',
      customColor: const Color(0xFF6F8F72),
      title: 'Inventory',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InventoryButton(
              imagePath: 'assets/counting.png',
              label: 'Counting',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => ProductInventoryBloc(
                        getProductInventoryByBarcodeUseCase:
                            GetProductInventoryByBarcodeUseCase(
                          ProductRepositoryImpl(),
                        ),
                      ),
                      child: CountingScreen(),
                    ),
                  ),
                );
              },
            ),
            InventoryButton(
              imagePath: 'assets/fresh.png',
              label: 'Fresh check',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FreshCheckScreen()),
                );
              },
            ),
            InventoryButton(
              imagePath: 'assets/reordering.png',
              label: 'Reordering',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReorderingScreen()),
                );
              },
            ),
            InventoryButton(
              imagePath: 'assets/new.png',
              label: 'Add new item',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewItemScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InventoryButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onPressed;

  const InventoryButton({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.1; // 10% of the screen width
    final buttonWidth = screenWidth * 0.8; // 80% of the screen width

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: buttonWidth,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6F8F72),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                imagePath,
                width: imageSize,
                height: imageSize,
                fit: BoxFit
                    .contain, // Adjust the image to contain within the bounds
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
