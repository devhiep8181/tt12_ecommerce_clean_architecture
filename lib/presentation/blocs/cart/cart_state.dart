part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState(this.status, this.listProduct, this.countCart, this.productQuantities);
  final CartStatus status;
  final List<Product> listProduct;
  final num countCart;
  final Map<num?, num> productQuantities;

  @override
  List<Object> get props => [status, listProduct, countCart, productQuantities];

  CartState copyWith({
    CartStatus? status,
    List<Product>? listProduct,
    num? countCart,
    Map<num?, num>? productQuantities
  }) {
    return CartState(
      status ?? this.status,
      listProduct ?? this.listProduct,
      countCart ?? this.countCart,
      productQuantities ?? this.productQuantities,
    );
  }
}

enum CartStatus { initial, loading, success, error }

extension CartStatusX on CartStatus {
  bool get isLoadingOrSuccess => [
        CartStatus.loading,
        CartStatus.success,
      ].contains(this);
}
