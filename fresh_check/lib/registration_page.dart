import 'package:flutter/material.dart';
import 'confirmation_page.dart';

class RegistrationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
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
              _buildTextField('Employ number'),
              _buildTextField('Name'),
              _buildTextField('Surname'),
              _buildTextField('Email'),
              _buildTextField('Username'),
              _buildTextField('Password', obscureText: true),
              _buildTextField('Password Confirmation', obscureText: true),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Checkbox(value: false, onChanged: (bool? value) {}),
                  Text('Agree to Terms & Conditions')
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6F8F72),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConfirmationPage()),
                    );
                  }
                },
                child: Text(
                  'Sign-up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  Color(0xFF77AD78), // Border color when the field is enabled
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  Color(0xFF77AD78), // Border color when the field is focused
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
