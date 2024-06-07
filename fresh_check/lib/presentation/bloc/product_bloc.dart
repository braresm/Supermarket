import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_check/domain/models/inventory.dart';
import 'package:fresh_check/domain/models/product.dart';
import 'package:fresh_check/domain/usecases/add_product_usecase.dart';
import 'package:fresh_check/domain/usecases/get_product_by_barcode_usecase.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductByBarcodeUseCase getProductByBarcodeUseCase;
  final AddProductUseCase addProductUseCase;

  ProductBloc(
      {required this.getProductByBarcodeUseCase,
      required this.addProductUseCase})
      : super(ProductInitial()) {
    on<GetProductByBarcode>(_onGetProductByBarcode);
    on<AddProduct>(_onAddProduct);
  }

  Future<void> _onGetProductByBarcode(
      GetProductByBarcode event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final product = await getProductByBarcodeUseCase(event.barcode);
      emit(ProductLoaded(product));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onAddProduct(
      AddProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      await addProductUseCase(event.product, event.inventory);
      emit(ProductAdded());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}

// Define Product events
class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductByBarcode extends ProductEvent {
  final String barcode;

  const GetProductByBarcode(this.barcode);
}

class AddProduct extends ProductEvent {
  final Product product;
  final Inventory inventory;

  const AddProduct(this.product, this.inventory);

  @override
  List<Object> get props => [product];
}

// Define Product states
class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

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
