part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddProductToCartEvent extends CartEvent {
  final Product product;
  final num countProduct; 
  const AddProductToCartEvent({required this.product, required this.countProduct});

  @override
  List<Object> get props => [product, countProduct];
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
