import 'dart:convert';
import 'package:hosco_clean_architecture/domain/entities/product/product.dart';

class ProductModel extends Product {
  const ProductModel(
      {super.id,
      super.title,
      super.description,
      super.price,
      super.discountPercentage,
      super.rating,
      super.stock,
      super.brand,
      super.category,
      super.thumbnail});

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        price: map['price'],
        discountPercentage: map['discountPercentage'],
        rating: map['rating'],
        stock: map['stock'],
        brand: map['brand'],
        category: map['category'],
        thumbnail: map['thumbnail']);
  }
  factory ProductModel.fromJson(String source) {
    return ProductModel.fromMap(json.decode(source));
  }
}
