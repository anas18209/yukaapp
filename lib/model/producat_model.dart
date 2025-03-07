class Product {
  String code;
  ProductDetails product;

  Product({required this.code, required this.product});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(code: json['code'] ?? '', product: ProductDetails.fromJson(json['product'] ?? {}));
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'product': product.toJson()};
  }
}

class ProductDetails {
  String id;
  String? productName;
  String imageUrl;
  String brands;
  String ingredientsText;
  List<String> categories;
  Nutriments nutriments;

  ProductDetails({
    required this.id,
    required this.productName,
    required this.imageUrl,
    required this.brands,
    required this.ingredientsText,
    required this.categories,
    required this.nutriments,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['_id'] ?? '',
      productName: json['product_name'] ?? 'No name available',
      imageUrl: json['image_url'] ?? '',
      brands: json['brands'] ?? 'Unknown brand',
      ingredientsText: json['ingredients_text'] ?? 'No ingredients available',
      categories: (json['categories'] != null) ? List<String>.from(json['categories'].split(', ')) : [],
      nutriments: json['nutriments'] != null ? Nutriments.fromJson(json['nutriments']) : Nutriments.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'product_name': productName,
      'image_url': imageUrl,
      'brands': brands,
      'ingredients_text': ingredientsText,
      'categories': categories.join(', '),
      'nutriments': nutriments.toJson(),
    };
  }
}

class Nutriments {
  double carbohydrates;
  double energyKcal;
  double fat;
  double proteins;
  double salt;
  double sugars;
  double sugarsserving;
  double energyKj;
  double energykcalserving;
  double fiber;
  double saturatedFat;
  double sodium;
  int nutritionScoreFr;

  Nutriments({
    required this.carbohydrates,
    required this.energyKcal,
    required this.fat,
    required this.proteins,
    required this.salt,
    required this.sugars,
    required this.energyKj,
    required this.fiber,
    required this.saturatedFat,
    required this.sodium,
    required this.nutritionScoreFr,
    required this.energykcalserving,
    required this.sugarsserving,
  });

  factory Nutriments.fromJson(Map<String, dynamic> json) {
    return Nutriments(
      carbohydrates: (json['carbohydrates'] ?? 0).toDouble(),
      energyKcal: (json['energy-kcal'] ?? 0).toDouble(),
      fat: (json['fat'] ?? 0).toDouble(),
      proteins: (json['proteins'] ?? 0).toDouble(),
      salt: (json['salt'] ?? 0).toDouble(),
      sugars: (json['sugars'] ?? 0).toDouble(),
      sugarsserving: (json['sugars_serving'] ?? 0).toDouble(),
      energyKj: (json['energy-kj'] ?? 0).toDouble(),
      energykcalserving: (json['energy-kcal_serving'] ?? 0).toDouble(),
      fiber: (json['fiber'] ?? 0).toDouble(),
      saturatedFat: (json['saturated-fat'] ?? 0).toDouble(),
      sodium: (json['sodium'] ?? 0).toDouble(),
      nutritionScoreFr: (json['nutrition-score-fr'] ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carbohydrates': carbohydrates,
      'energy-kcal': energyKcal,
      'fat': fat,
      'proteins': proteins,
      'salt': salt,
      'sugars': sugars,
      'energy-kj': energyKj,
      'fiber': fiber,
      'saturated-fat': saturatedFat,
      'sodium': sodium,
      'nutrition-score-fr': nutritionScoreFr,
    };
  }

  factory Nutriments.empty() {
    return Nutriments(
      carbohydrates: 0,
      energyKcal: 0,
      fat: 0,
      proteins: 0,
      salt: 0,
      sugars: 0,
      energyKj: 0,
      fiber: 0,
      saturatedFat: 0,
      sodium: 0,
      nutritionScoreFr: 0,
      energykcalserving: 0,
      sugarsserving: 0,
    );
  }
}
