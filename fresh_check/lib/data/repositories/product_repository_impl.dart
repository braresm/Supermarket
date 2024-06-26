import 'package:fresh_check/data/repositories/product_repository.dart';
import 'package:fresh_check/domain/models/inventory.dart';
import 'package:fresh_check/domain/models/product.dart';
import 'package:fresh_check/domain/models/product_inventory.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl();

  /// Get a product by barcode
  @override
  Future<Product?> getProductByBarcode(int barcode) async {
    final response = await Supabase.instance.client
        .from('products')
        .select()
        .eq('barcode', barcode);

    if (response.isEmpty) {
      return null;
    }

    var result = response[0];

    return Product(
      id: result['id'],
      name: result['product_name'],
      categoty: result['category'],
      price: result['price'],
      barcode: result['barcode'],
      location: result['location'],
      details: result['product_details'],
      imageUrl: result['product_image'],
    );
  }

  /// Add a product to the database
  @override
  Future<void> addProduct(Product product, Inventory inventory) async {
    final response = await Supabase.instance.client.from('products').insert({
      'product_name': product.name,
      'location': product.location,
      'product_details': product.details,
      'product_image': product.imageUrl,
      'barcode': product.barcode,
      'category': product.categoty,
      'price': product.price,
    }).select();

    if (response.isNotEmpty && response[0].containsKey('error')) {
      throw Exception(response[0]['error']['message']);
    }

    // Extract the product ID from the response
    final productId = response[0]['id'];
    final expirationDate = DateTime.now().add(const Duration(days: 30));

    await Supabase.instance.client.from('inventory').upsert({
      'product_id': productId,
      'quantity': inventory.quantity,
      'expiration_date': expirationDate.toIso8601String(),
    });
  }

  /// Get the product inventory by barcode
  @override
  Future<ProductInventory?> getProductInventoryByBarcode(int barcode) async {
    final response = await Supabase.instance.client
        .from('products')
        .select(
            'product_name, category, location, product_details, product_image, inventory(quantity, expiration_date)')
        .eq('barcode', barcode);

    if (response.isEmpty) {
      return null;
    }

    return ProductInventory(
      name: response[0]['product_name'],
      quantity: response[0]['inventory'][0]['quantity'],
      expirationDate: response[0]['inventory'][0]['expiration_date'],
      category: response[0]['category'],
      location: response[0]['location'],
      details: response[0]['product_details'],
      imageUrl: response[0]['product_image'],
    );
  }
}
