import 'package:equatable/equatable.dart';
import 'package:fresh_check/domain/models/inventory.dart';
import 'package:fresh_check/domain/models/product.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

// Define concrete Product events

class AddProduct extends ProductEvent {
  final Product product;
  final Inventory inventory;

  const AddProduct(this.product, this.inventory);

  @override
  List<Object> get props => [product];
}
