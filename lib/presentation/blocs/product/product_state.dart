part of 'product_bloc.dart';

extension ProductStatusX on ProductStatus {
  bool get isLoading => [ProductStatus.loading].contains(this);
  bool get isLoaded => [ProductStatus.loaded].contains(this);
}

class ProductState extends Equatable {
  const ProductState(
    this.status,
    this.product,
    this.description,
  );
  final ProductStatus status;
  final List<Product> product;
  final String description;

  @override
  List<Object> get props => [status, product, description];

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? product,
    String? description,
  }) {
    return ProductState(
      status ?? this.status,
      product ?? this.product,
      description ?? this.description,
    );
  }
}
enum ProductStatus { initial, loading, loaded, error }
