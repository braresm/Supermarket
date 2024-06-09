class ProductInventory {
  final String name;
  final int quantity;
  final String category;
  final String location;
  final String? details;
  final String? imageUrl;
  final String expirationDate;

  ProductInventory({
    required this.name,
    required this.quantity,
    required this.category,
    required this.location,
    required this.details,
    required this.imageUrl,
    required this.expirationDate,
  });
}
