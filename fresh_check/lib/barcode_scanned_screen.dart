import 'package:flutter/material.dart';
import 'barcode_scanning.dart';

class BarcodeScannedScreen extends StatelessWidget {
  final String barcode;

  BarcodeScannedScreen({required this.barcode});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double padding = screenSize.width * 0.05;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              children: [
                SizedBox(
                    height:
                        screenSize.height * 0.15), // Space for the back button
                Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(screenSize.width * 0.05),
                  ),
                  child: Center(
                    child: Text(
                      'Product Name',
                      style: TextStyle(
                        color: Color(0xFF6F8F72),
                        fontSize: screenSize.width * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.05),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: padding,
                    vertical: screenSize.height * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF6F8F72),
                    borderRadius:
                        BorderRadius.circular(screenSize.width * 0.05),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'barcode number',
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.only(left: padding),
                    ),
                    style: TextStyle(color: Colors.white),
                    controller: TextEditingController(text: barcode),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.05),
                Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    color: Color(0xFF5F705F),
                    borderRadius:
                        BorderRadius.circular(screenSize.width * 0.05),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Units:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenSize.width * 0.05,
                        ),
                      ),
                      Text(
                        '7', // This should be replaced with the actual product units data
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenSize.width * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenSize.height * 0.05),
                Container(
                  height: screenSize.height * 0.3,
                  decoration: BoxDecoration(
                    color: Color(0xFFD3D3D3),
                    borderRadius:
                        BorderRadius.circular(screenSize.width * 0.05),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: screenSize.height * 0.05,
            left: padding,
            child: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Colors.white, size: screenSize.width * 0.08),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: BarcodeScannerScreen(),
    ));
