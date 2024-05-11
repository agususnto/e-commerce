import 'package:ecommerce/models/Product.dart';

class Cart {
  final Product product;
  int numOfItem;

  Cart({
    required this.product,
    required this.numOfItem,
  });

  // Override == and hashCode for object comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart &&
        other.product == product &&
        other.numOfItem == numOfItem;
  }

  @override
  int get hashCode => product.hashCode ^ numOfItem.hashCode;

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'numOfItem': numOfItem,
    };
  }

  // Buat dari JSON
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      product: Product.fromJson(json['product']),
      numOfItem: json['numOfItem'],
    );
  }
}
