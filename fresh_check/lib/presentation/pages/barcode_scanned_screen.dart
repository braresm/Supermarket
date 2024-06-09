import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_check/domain/models/product_inventory.dart';
import 'package:fresh_check/presentation/bloc/product_inventory/product_inventory_bloc.dart';
import 'package:fresh_check/presentation/bloc/product_inventory/product_inventory_event.dart';
import 'package:fresh_check/presentation/bloc/product_inventory/product_inventory_state.dart';

class BarcodeScannedScreen extends StatelessWidget {
  final int barcode;

  const BarcodeScannedScreen({super.key, required this.barcode});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    context.read<ProductInventoryBloc>().add(
          GetProductInventoryByBarcodeEvent(barcode),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanned'),
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
            return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // show loading indicator if the state is ProductInventoryLoading
                      if (state is ProductInventoryLoading)
                        const Center(
                          child: CircularProgressIndicator(),
                        )

                      // Show the product information if the state is ProductInventoryLoaded
                      else if (state is ProductInventoryLoaded)
                        if (state.productInventory != null)
                          ...productInformation(
                              state.productInventory!, screenSize)
                        else
                          const Center(
                            child: Text('Product not found'),
                          )
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }

  /// Display the product information
  List<Widget> productInformation(
      ProductInventory productInventory, Size screenSize) {
    return [
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenSize.width * 0.05),
        ),
        child: Center(
          child: Text(
            productInventory.name,
            style: TextStyle(
              color: const Color(0xFF6F8F72),
              fontSize: screenSize.width * 0.07,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Container(
        width: screenSize.width,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF6F8F72),
          borderRadius: BorderRadius.circular(screenSize.width * 0.05),
        ),
        child: Text(
          barcode.toString(),
          style: TextStyle(
            fontSize: screenSize.width * 0.05,
          ),
        ),
      ),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF5F705F),
          borderRadius: BorderRadius.circular(screenSize.width * 0.05),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Product Units:',
              style: TextStyle(
                fontSize: screenSize.width * 0.05,
              ),
            ),
            Text(
              productInventory.quantity.toString(),
              style: TextStyle(
                fontSize: screenSize.width * 0.05,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF5F705F),
          borderRadius: BorderRadius.circular(screenSize.width * 0.05),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Expiration date:',
              style: TextStyle(
                fontSize: screenSize.width * 0.05,
              ),
            ),
            Text(
              productInventory.expirationDate,
              style: TextStyle(
                fontSize: screenSize.width * 0.05,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF5F705F),
          borderRadius: BorderRadius.circular(screenSize.width * 0.05),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Category:',
              style: TextStyle(
                fontSize: screenSize.width * 0.05,
              ),
            ),
            Text(
              productInventory.category,
              style: TextStyle(
                fontSize: screenSize.width * 0.05,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF5F705F),
          borderRadius: BorderRadius.circular(screenSize.width * 0.05),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Location:',
              style: TextStyle(
                fontSize: screenSize.width * 0.05,
              ),
            ),
            Text(
              productInventory.location,
              style: TextStyle(
                fontSize: screenSize.width * 0.05,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF5F705F),
          borderRadius: BorderRadius.circular(screenSize.width * 0.05),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Details:',
              style: TextStyle(
                fontSize: screenSize.width * 0.05,
              ),
            ),
            Text(
              productInventory.details ?? 'No details available',
              style: TextStyle(
                fontSize: screenSize.width * 0.05,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Container(
        height: screenSize.height * 0.3,
        decoration: BoxDecoration(
          color: const Color(0xFFD3D3D3),
          borderRadius: BorderRadius.circular(screenSize.width * 0.05),
        ),
        child: productInventory.imageUrl != null &&
                productInventory.imageUrl!.isNotEmpty
            ? Image.network(
                productInventory.imageUrl!,
                fit: BoxFit.cover,
              )
            : const Center(
                child: Text('No image available'),
              ),
      )
    ];
  }
}
