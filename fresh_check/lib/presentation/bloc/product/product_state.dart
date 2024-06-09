import 'package:equatable/equatable.dart';
import 'package:fresh_check/domain/models/product.dart';

class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

// Define concrete Product states

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductAdded extends ProductState {}

class ProductLoaded extends ProductState {
  final Product? product;

  const ProductLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
