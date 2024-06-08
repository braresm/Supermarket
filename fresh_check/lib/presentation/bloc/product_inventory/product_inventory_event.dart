import 'package:equatable/equatable.dart';

class ProductInventoryEvent extends Equatable {
  const ProductInventoryEvent();

  @override
  List<Object> get props => [];
}

// Define concrete events for the ProductInventory page

class GetProductInventoryByBarcodeEvent extends ProductInventoryEvent {
  final int barcode;

  const GetProductInventoryByBarcodeEvent(this.barcode);
}
