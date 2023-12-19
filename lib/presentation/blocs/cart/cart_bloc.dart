import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hosco_clean_architecture/domain/entities/product/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState(CartStatus.initial, [], 0, {})) {
    on<AddProductToCartEvent>(_onAddProductToCart);
    on<RemoveProductToCartEvent>(_onRemoveProductToCart);
  }
  Map<num?, num> mapProduct = {};
  FutureOr<void> _onAddProductToCart(
    AddProductToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CartStatus.loading));
      Product product = event.product;
      num countItemProduct = event.countProduct;
      List<Product> listCart = List.from(state.listProduct);
      if (!listCart.contains(product)) {
        listCart.add(product);
      }
      mapProduct[product.id] = countItemProduct;
      num? totalItemCart;
      for(var key in mapProduct.keys){
        totalItemCart = (totalItemCart ?? 0) + mapProduct[key]!;
      }
      emit(state.copyWith(
          status: CartStatus.success,
          listProduct: listCart,
          countCart: totalItemCart,
          productQuantities: mapProduct));
      add(ShowCartEvent(cartItem: listCart));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.error));
    }
  }

  FutureOr<void> _onRemoveProductToCart(
    RemoveProductToCartEvent event,
    Emitter<CartState> emitt,
  ) async {
    try {
      final Product product = event.product;
      List<Product> listCart = List.from(state.listProduct);
      listCart.remove(product);
      emitt(
        state.copyWith(status: CartStatus.success, listProduct: listCart),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emitt(state.copyWith(status: CartStatus.error));
    }
  }
}
