import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_check/domain/usecases/get_product_inventory_by_barcode_usecase.dart';
import 'package:fresh_check/presentation/bloc/product_inventory/product_inventory_event.dart';
import 'package:fresh_check/presentation/bloc/product_inventory/product_inventory_state.dart';

class ProductInventoryBloc
    extends Bloc<ProductInventoryEvent, ProductInventoryState> {
  final GetProductInventoryByBarcodeUseCase getProductInventoryByBarcodeUseCase;

  ProductInventoryBloc({
    required this.getProductInventoryByBarcodeUseCase,
  }) : super(ProductInventoryInitial()) {
    // Define actions for events
    on<GetProductInventoryByBarcodeEvent>(_onGetProductInventoryByBarcode);
  }

  /// Get the product inventory by the barcode value
  Future<void> _onGetProductInventoryByBarcode(
      GetProductInventoryByBarcodeEvent event,
      Emitter<ProductInventoryState> emit) async {
    emit(ProductInventoryLoading());

    try {
      final productInventory =
          await getProductInventoryByBarcodeUseCase(event.barcode);
      emit(ProductInventoryLoaded(productInventory));
    } catch (e) {
      emit(ProductInventoryError(e.toString()));
    }
  }
}
