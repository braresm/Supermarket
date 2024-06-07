import 'package:fresh_check/domain/models/inventory.dart';
import 'package:fresh_check/domain/models/product.dart';

abstract class ProductRepository {
  Future<Product?> getProductByBarcode(String barcode);
  Future<void> addProduct(Product product, Inventory inventory);
}
