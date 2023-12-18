part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddProductToCartEvent extends CartEvent {
  final Product product;
  const AddProductToCartEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveProductToCartEvent extends CartEvent {
  final Product product;
  const RemoveProductToCartEvent({required this.product});
}


class ShowCartEvent extends CartEvent {
  final List<Product> cartItem;
  const ShowCartEvent({required this.cartItem});

  @override
  List<Object> get props => [cartItem];
}
