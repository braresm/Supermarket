import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_check/domain/models/product_inventory.dart';
import 'package:fresh_check/presentation/bloc/product_inventory/product_inventory_bloc.dart';
import 'package:fresh_check/presentation/bloc/product_inventory/product_inventory_event.dart';
import 'package:fresh_check/presentation/bloc/product_inventory/product_inventory_state.dart';

class CountingScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _barcodeController = TextEditingController();

  CountingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counting'),
        backgroundColor: const Color(0xFF6F8F72),
      ),
      body: BlocListener<ProductInventoryBloc, ProductInventoryState>(
        listener: (context, state) {
          if (state is ProductInventoryError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
        },
        child: BlocBuilder<ProductInventoryBloc, ProductInventoryState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  productSearchForm(context),

                  // show loading indicator if the state is ProductInventoryLoading
                  if (state is ProductInventoryLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    )

                  // Show the product information if the state is ProductInventoryLoaded
                  else if (state is ProductInventoryLoaded)
                    if (state.productInventory != null)
                      productInformation(state.productInventory!)
                    else
                      const Text('Product not found'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Display the product search form
  Widget productSearchForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Product Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _barcodeController,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product number';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Trigger the event to get the product by barcode
                    context.read<ProductInventoryBloc>().add(
                          GetProductInventoryByBarcodeEvent(
                            int.parse(_barcodeController.text),
                          ),
                        );
                    // Clear the form
                    _formKey.currentState!.reset();
                  }
                },
                child: const Text(
                  'Search',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Display the product information
  Widget productInformation(ProductInventory productInventory) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFAED3A4),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            productInventory.name,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(12),
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
              Text(
                productInventory.quantity.toString(),
                style: const TextStyle(
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
        ),
      ]),
    );
  }
}
