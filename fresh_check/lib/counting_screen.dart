import 'package:flutter/material.dart';

class CountingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counting'),
        backgroundColor: Color(0xFF6F8F72),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Product Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFAED3A4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Product Name',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Number of the product:',
                  filled: true,
                  fillColor: Color(0xFFAED3A4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.qr_code, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFAED3A4),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Text(
                      'Product Units: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '7',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // Handle edit button press
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6F8F72),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  // Handle save button press
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
