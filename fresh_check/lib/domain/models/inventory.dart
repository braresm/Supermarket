class Inventory {
  final int productId;
  final int quantity;
  final DateTime? expirationDate;

  Inventory({
    required this.productId,
    required this.quantity,
    this.expirationDate,
  });
}
