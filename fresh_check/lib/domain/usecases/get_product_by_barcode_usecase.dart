import 'package:fresh_check/data/repositories/product_repository.dart';
import 'package:fresh_check/domain/models/product.dart';

class GetProductByBarcodeUseCase {
  final ProductRepository repository;

  GetProductByBarcodeUseCase(this.repository);

  Future<Product?> call(int barcode) {
    return repository.getProductByBarcode(barcode);
  }
}
