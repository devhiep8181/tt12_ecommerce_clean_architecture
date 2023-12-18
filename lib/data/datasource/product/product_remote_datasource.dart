import 'dart:convert';

import 'package:hosco_clean_architecture/data/model/product/product_model.dart';
import 'package:hosco_clean_architecture/domain/entities/product/product.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  Future<List<Product>> getListProduct();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<List<Product>> getListProduct() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    // final data = json.decode(response.body);
    // print(data);
    //List<Product> listProduct = [];

    // for (int i = 0; i < data['products'].length; i++) {
    //   listProduct.add(ProductModel.fromMap(data['products'][i]));
    // }
final rawData = List<Map<String, dynamic>>.from(Map<String, dynamic>.from(Map<String, dynamic>.from(
      json.decode(response.body),
    ))['products']);
    final listResult = rawData.map(
      (e) =>ProductModel.fromMap(e),
    );

    return listResult.toList();
  }
}
