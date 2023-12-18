import 'package:hosco_clean_architecture/core/usecase/usecase.dart';
import 'package:hosco_clean_architecture/domain/entities/product/product.dart';
import 'package:hosco_clean_architecture/domain/repositories/product/product_repositories.dart';

class GetListProductUC extends UseCase {
  final ProductRepository productRepository;
  GetListProductUC({required this.productRepository});

  @override
  Future<List<Product>> call(params) async {
    return await productRepository.getListProduct();
  }
}
