import 'package:get_it/get_it.dart';
import 'package:hosco_clean_architecture/data/datasource/product/product_remote_datasource.dart';
import 'package:hosco_clean_architecture/data/repositories/product/product_repository_impl.dart';
import 'package:hosco_clean_architecture/domain/repositories/product/product_repositories.dart';
import 'package:hosco_clean_architecture/domain/usecase/product/get_list_product.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
//! UseCase

  sl.registerLazySingleton<GetListProductUC>(
      () => GetListProductUC(productRepository: sl()));

//! Repository

  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productRemoteDataSource: sl()));

//! DataSource

  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl());
}
