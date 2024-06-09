import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_check/domain/usecases/add_product_usecase.dart';
import 'package:fresh_check/domain/usecases/get_product_by_barcode_usecase.dart';
import 'package:fresh_check/presentation/bloc/product/product_event.dart';
import 'package:fresh_check/presentation/bloc/product/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductByBarcodeUseCase getProductByBarcodeUseCase;
  final AddProductUseCase addProductUseCase;

  ProductBloc(
      {required this.getProductByBarcodeUseCase,
      required this.addProductUseCase})
      : super(ProductInitial()) {
    on<AddProduct>(_onAddProduct);
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
