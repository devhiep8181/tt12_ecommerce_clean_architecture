import 'package:hosco_clean_architecture/data/datasource/product/product_remote_datasource.dart';
import 'package:hosco_clean_architecture/domain/entities/product/product.dart';
import 'package:hosco_clean_architecture/domain/repositories/product/product_repositories.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  ProductRepositoryImpl({required this.productRemoteDataSource});

  @override
  Future<List<Product>> getListProduct() async {
    return await productRemoteDataSource.getListProduct();
  }
}
