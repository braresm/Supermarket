import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:fresh_check/data/repositories/product_repository_impl.dart';
import 'package:fresh_check/domain/usecases/get_product_inventory_by_barcode_usecase.dart';
import 'package:fresh_check/presentation/bloc/product_inventory/product_inventory_bloc.dart';
import 'barcode_scanned_screen.dart';
import '../widgets/custom_scaffold.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String barcode = '';

  Future<void> scanBarcode() async {
    try {
      final result = await BarcodeScanner.scan();
      if (result.rawContent.isNotEmpty && mounted) {
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
              child: BarcodeScannedScreen(
                barcode: int.parse(result.rawContent),
              ),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to get barcode: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final iconSize =
        screenSize.width * 0.7; // Increase the size to 70% of the screen width
    final buttonPadding = EdgeInsets.symmetric(
      horizontal: screenSize.width * 0.1,
      vertical: screenSize.height * 0.02,
    );

    return CustomScaffold(
      employeeName: 'Employee Name',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.qr_code,
              size: iconSize,
              color: const Color(0xFF6F8F72), // Matching icon color with theme
            ),
            SizedBox(height: screenSize.height * 0.05),
            ElevatedButton(
              onPressed: scanBarcode,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF6F8F72),
                padding: buttonPadding,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Scan Barcode',
                style: TextStyle(fontSize: screenSize.width * 0.05),
              ),
            ),
          ],
        ),
      ),
      customColor: const Color(0xFF6F8F72),
      title: 'Barcode Scanner',
    );
  }
}
