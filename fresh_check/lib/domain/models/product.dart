class Product {
  final int id;
  final String name;
  final String categoty;
  final String location;
  final String barcode;
  final double price;
  final DateTime? createdAt;

  Product({
    required this.id,
    required this.name,
    required this.categoty,
    required this.location,
    required this.barcode,
    required this.price,
    this.createdAt,
  });
}
