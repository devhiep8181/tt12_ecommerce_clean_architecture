import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosco_clean_architecture/core/constants/variables.dart';
import 'package:hosco_clean_architecture/domain/entities/product/product.dart';
import 'package:hosco_clean_architecture/presentation/blocs/cart/cart_bloc.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cartItem;

  const CartScreen({Key? key, required this.cartItem}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: widget.cartItem.isEmpty
          ? const Center(
              child: Text(
                "Empty",
                style: TextStyle(color: textProductDetailColor),
              ),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CartItemList(cartItems: widget.cartItem),
              ),
            ),
    );
  }
}

class CartItemList extends StatelessWidget {
  final List<Product> cartItems;
  const CartItemList({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.listProduct.length,
          padding: const EdgeInsets.only(bottom: 4),
          itemBuilder: (_, index) {
            // Product product = state.listProduct[index];
            print("${state.productQuantities}");
            return CartItemTile(
              product: state.listProduct[index],
              mapProduct: state.productQuantities,
            );
          },
        );
      },
    );
  }
}

class CartItemTile extends StatelessWidget {
  final Product product;
  final Map<num?, num> mapProduct;
  const CartItemTile(
      {Key? key, required this.product, required this.mapProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: const Color(0xffffffff),
      title: Text(product.title ?? ""),
      subtitle: Text("x${mapProduct[product.id]}"),
      leading: Image.network(
        product.thumbnail ?? "",
        fit: BoxFit.fill,
        width: 60,
        height: 40,
      ),
      trailing: IconButton(
        onPressed: () {
          BlocProvider.of<CartBloc>(context).add(RemoveProductToCartEvent(
            product: product,
          ));
        },
        icon: const Icon(Icons.close),
      ),
    );
  }
}
