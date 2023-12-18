import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hosco_clean_architecture/core/usecase/usecase.dart';
import 'package:hosco_clean_architecture/domain/usecase/product/get_list_product.dart';

import '../../../domain/entities/product/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  GetListProductUC getListProductUC;
  ProductBloc({required this.getListProductUC})
      : super(const ProductState(ProductStatus.initial, [], '')) {
    on<GetListProductEvent>(_onGetListProduct);
  }

  FutureOr<void> _onGetListProduct(
    GetListProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ProductStatus.loading));
      final result = await getListProductUC(NoParams());
      emit(state.copyWith(status: ProductStatus.loaded, product: result));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          status: ProductStatus.error, description: e.toString()));
    }
  }
}
