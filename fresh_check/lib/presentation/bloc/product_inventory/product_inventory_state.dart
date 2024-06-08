import 'package:equatable/equatable.dart';
import 'package:fresh_check/domain/models/product_inventory.dart';

class ProductInventoryState extends Equatable {
  const ProductInventoryState();

  @override
  List<Object?> get props => [];
}

// Define concrete states for ProductInventory

class ProductInventoryInitial extends ProductInventoryState {}

class ProductInventoryLoading extends ProductInventoryState {}

class ProductInventoryLoaded extends ProductInventoryState {
  final ProductInventory? productInventory;

  const ProductInventoryLoaded(this.productInventory);

  @override
  List<Object?> get props => [productInventory];
}

class ProductInventoryError extends ProductInventoryState {
  final String message;

  const ProductInventoryError(this.message);

  @override
  List<Object?> get props => [message];
}
