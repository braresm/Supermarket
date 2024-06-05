import 'package:flutter/material.dart';
import 'package:fresh_check/home_screen.dart';

import 'barcode_scanned_screen.dart';

class LoginScreen extends StatelessWidget {
  final Color customColor = const Color(0xFF6F8F72);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Fresh Check',
            style: TextStyle(
                fontSize: 62,
                fontWeight: FontWeight.bold,
                color: Color(0xFF77AD78)),
          ),
          SizedBox(height: 20),
          Image.asset('./assets/worker2.png'),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));},
                child: Text('Log In',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6F8F72),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                ),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text('Sign - up',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6F8F72),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
