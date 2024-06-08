import 'package:fresh_check/domain/models/inventory.dart';
import 'package:fresh_check/domain/models/product.dart';
import 'package:fresh_check/domain/models/product_inventory.dart';

abstract class ProductRepository {
  Future<Product?> getProductByBarcode(int barcode);
  Future<ProductInventory?> getProductInventoryByBarcode(int barcode);
  Future<void> addProduct(Product product, Inventory inventory);
}
