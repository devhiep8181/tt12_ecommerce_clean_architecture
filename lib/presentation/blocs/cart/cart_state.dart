part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState(this.status, this.listProduct);
  final CartStatus status;
  final List<Product> listProduct;

  @override
  List<Object> get props => [status, listProduct];

  CartState copyWith({
    CartStatus? status,
    List<Product>? listProduct,
  }) {
    return CartState(
      status ?? this.status,
      listProduct ?? this.listProduct,
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
