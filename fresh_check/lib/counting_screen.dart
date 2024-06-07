import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_check/presentation/bloc/product_bloc.dart';

class CountingScreen extends StatelessWidget {
  const CountingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counting'),
        backgroundColor: const Color(0xFF6F8F72),
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            Widget childWidget = Container();

            if (state is ProductLoading) {
              childWidget = const CircularProgressIndicator();
            }
            if (state is ProductInitial) {
              childWidget = const CountForm();
            }
            if (state is ProductLoaded) {
              childWidget = Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFAED3A4),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Product Units: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      '7',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // Handle edit button press
                      },
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Product Information',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    const SizedBox(height: 20),
                    childWidget,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CountForm extends StatefulWidget {
  const CountForm({super.key});

  @override
  _CountFormState createState() => _CountFormState();
}

class _CountFormState extends State<CountForm> {
  final _formKey = GlobalKey<FormState>();
  final _barcodeController = TextEditingController();

  String? _validateBarcode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Barcode cannot be empty';
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context
          .read<ProductBloc>()
          .add(GetProductByBarcode(_barcodeController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _barcodeController,
                validator: _validateBarcode,
                decoration: InputDecoration(
                  labelText: 'Number of the product:',
                  filled: true,
                  fillColor: const Color(0xFFAED3A4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.qr_code, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6F8F72),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: _submit,
                child: const Text(
                  'Count',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
