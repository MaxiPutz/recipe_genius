class BillaProduct {
  String seoTitle;
  String url;
  String articleOnlyCanonicalPath;
  String canonicalPath;
  List<String> paths;
  dynamic recipeID;
  String articleId;
  String name;
  dynamic grammageBadge;
  String grammageUnit;
  double grammagePriceFactor;
  String grammage;
  double minimalOrderQuantity;
  BillaPrice price;

  BillaProduct({
    required this.seoTitle,
    required this.url,
    required this.articleOnlyCanonicalPath,
    required this.canonicalPath,
    required this.paths,
    required this.recipeID,
    required this.articleId,
    required this.name,
    required this.grammageBadge,
    required this.grammageUnit,
    required this.grammagePriceFactor,
    required this.grammage,
    required this.minimalOrderQuantity,
    required this.price,
  });

  factory BillaProduct.fromJson(Map<String, dynamic> json) {
    return BillaProduct(
      seoTitle: json['seoTitle'],
      url: json['url'],
      articleOnlyCanonicalPath: json['articleOnlyCanonicalPath'],
      canonicalPath: json['canonicalPath'],
      paths: List<String>.from(json['paths'].map((x) => x)),
      recipeID: json['recipeID'],
      articleId: json['articleId'],
      name: json['name'],
      grammageBadge: json['grammageBadge'],
      grammageUnit: json['grammageUnit'],
      grammagePriceFactor: json['grammagePriceFactor'].toDouble(),
      grammage: json['grammage'],
      minimalOrderQuantity: json['minimalOrderQuantity'].toDouble(),
      price: BillaPrice.fromJson(json['price']),
    );
  }
}

class BillaPrice {
  double normal;
  double sale;
  String unit;
  double finalPrice;
  List<dynamic> priceTypeDefinitions;
  bool isQuantityDiscount;
  Map<String, dynamic> priceAdditionalInfo;
  List<dynamic> bulkDiscountPriceTypes;
  List<dynamic> defaultPriceTypes;
  bool isPlusPromotion;

  BillaPrice({
    required this.normal,
    required this.sale,
    required this.unit,
    required this.finalPrice,
    required this.priceTypeDefinitions,
    required this.isQuantityDiscount,
    required this.priceAdditionalInfo,
    required this.bulkDiscountPriceTypes,
    required this.defaultPriceTypes,
    required this.isPlusPromotion,
  });

  factory BillaPrice.fromJson(Map<String, dynamic> json) {
    return BillaPrice(
      normal: json['normal'].toDouble(),
      sale: json['sale'].toDouble(),
      unit: json['unit'],
      finalPrice: json['final'].toDouble(),
      priceTypeDefinitions:
          List<dynamic>.from(json['priceTypeDefinitions'].map((x) => x)),
      isQuantityDiscount: json['isQuantityDiscount'],
      priceAdditionalInfo:
          Map<String, dynamic>.from(json['priceAdditionalInfo']),
      bulkDiscountPriceTypes:
          List<dynamic>.from(json['bulkDiscountPriceTypes'].map((x) => x)),
      defaultPriceTypes:
          List<dynamic>.from(json['defaultPriceTypes'].map((x) => x)),
      isPlusPromotion: json['isPlusPromotion'],
    );
  }
}
