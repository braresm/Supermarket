import 'package:fresh_check/data/repositories/product_repository.dart';
import 'package:fresh_check/domain/models/inventory.dart';
import 'package:fresh_check/domain/models/product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl();

  @override
  Future<Product?> getProductByBarcode(String barcode) async {
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
    );
  }

  @override
  Future<void> addProduct(Product product, Inventory inventory) async {
    // Insert or update the product
    final response = await Supabase.instance.client.from('products').insert({
      'product_name': product.name,
      'location': product.location,
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
}
