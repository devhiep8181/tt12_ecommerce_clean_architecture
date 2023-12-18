import 'package:hosco_clean_architecture/domain/entities/product/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getListProduct();
}
