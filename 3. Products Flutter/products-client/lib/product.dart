class Product {
  /// Constructor
  const Product(
    this.id, 
    this.price, 
    this.name, 
    this.brand, 
    this.description, 
    this.link
  );

  /// Product ID
  final String id;

  // Product price in euros
  final String price;

  /// Product name
  final String name;

  /// Product brand
  final String brand;

  /// Product description
  final String description;

  /// Product page link
  final String link;
}