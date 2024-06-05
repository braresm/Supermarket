import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // Center widget to horizontally align content
        child: SingleChildScrollView(
          // Scrollable content
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center horizontally
              mainAxisSize: MainAxisSize.min, // Center the content
              children: <Widget>[
                SizedBox(height: 40),
                Text(
                  'Fresh Check',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF77AD78),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'For security reasons we sent a code for confirmation to your email. '
                  'Please check your inbox and fill the code in the field below.',
                  style: TextStyle(fontSize: 20, color: Color(0xFF77AD78)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                _buildConfirmationCodeFields(),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: Text(
                      "Didn't receive a confirmation code? Tap here to get a new one!"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6F8F72),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle the confirmation logic here
                      }
                    },
                    child: Text('Sign-up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmationCodeFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return Container(
          width: 40,
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null;
            },
          ),
        );
      }),
    );
  }
}
