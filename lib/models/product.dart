enum ProductStatus { draft, published, archived }

class Product {
  final String id;
  final String name;
  final String scientificName;
  final String description;
  final double price;
  final double? oldPrice;
  final String category;
  final List<String> imageUrls;
  final ProductStatus status;
  final int stock;
  final String? sku;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isIndoor;
  final String difficulty;
  final String lightRequirement;
  final String waterRequirement;

  Product({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.description,
    required this.price,
    this.oldPrice,
    required this.category,
    required this.imageUrls,
    required this.status,
    required this.stock,
    this.sku,
    required this.createdAt,
    required this.updatedAt,
    required this.isIndoor,
    required this.difficulty,
    required this.lightRequirement,
    required this.waterRequirement,
  });

  Product copyWith({
    String? id,
    String? name,
    String? scientificName,
    String? description,
    double? price,
    double? oldPrice,
    String? category,
    List<String>? imageUrls,
    ProductStatus? status,
    int? stock,
    String? sku,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isIndoor,
    String? difficulty,
    String? lightRequirement,
    String? waterRequirement,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      scientificName: scientificName ?? this.scientificName,
      description: description ?? this.description,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      category: category ?? this.category,
      imageUrls: imageUrls ?? this.imageUrls,
      status: status ?? this.status,
      stock: stock ?? this.stock,
      sku: sku ?? this.sku,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isIndoor: isIndoor ?? this.isIndoor,
      difficulty: difficulty ?? this.difficulty,
      lightRequirement: lightRequirement ?? this.lightRequirement,
      waterRequirement: waterRequirement ?? this.waterRequirement,
    );
  }
}
