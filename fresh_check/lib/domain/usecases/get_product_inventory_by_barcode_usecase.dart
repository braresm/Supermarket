import 'package:fresh_check/data/repositories/product_repository.dart';
import 'package:fresh_check/domain/models/product_inventory.dart';

class GetProductInventoryByBarcodeUseCase {
  final ProductRepository repository;

  GetProductInventoryByBarcodeUseCase(this.repository);

  Future<ProductInventory?> call(int barcode) {
    return repository.getProductInventoryByBarcode(barcode);
  }
}
