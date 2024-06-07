import 'package:fresh_check/data/repositories/product_repository.dart';
import 'package:fresh_check/domain/models/inventory.dart';

import '../models/product.dart';

class AddProductUseCase {
  final ProductRepository repository;

  AddProductUseCase(this.repository);

  Future<void> call(Product product, Inventory inventory) async {
    await repository.addProduct(product, inventory);
  }
}
