import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'barcode_scanned_screen.dart';
import 'custom_scaffold.dart';

class BarcodeScannerScreen extends StatefulWidget {
  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String barcode = '';

  Future<void> scanBarcode() async {
    try {
      final result = await BarcodeScanner.scan();
      setState(() {
        barcode = result.rawContent;
      });
      if (barcode.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BarcodeScannedScreen(barcode: barcode),
          ),
        );
      }
    } catch (e) {
      setState(() {
        barcode = 'Failed to get barcode: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final iconSize = screenSize.width * 0.7; // Increase the size to 70% of the screen width
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
              color: Color(0xFF6F8F72), // Matching icon color with theme
            ),
            SizedBox(height: screenSize.height * 0.05),
            ElevatedButton(
              onPressed: scanBarcode,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF6F8F72),
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
      customColor: Color(0xFF6F8F72),
      title: 'Barcode Scanner',
    );
  }
}

void main() => runApp(MaterialApp(
  home: BarcodeScannerScreen(),
));
