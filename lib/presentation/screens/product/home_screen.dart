import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosco_clean_architecture/core/constants/variables.dart';
import 'package:hosco_clean_architecture/domain/entities/product/product.dart';
import 'package:hosco_clean_architecture/presentation/blocs/cart/cart_bloc.dart';
import 'package:hosco_clean_architecture/presentation/blocs/product/product_bloc.dart';
import 'package:hosco_clean_architecture/presentation/screens/cart/cart_screen.dart';
import 'package:hosco_clean_architecture/presentation/screens/product/product_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetListProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CartScreen(cartItem: state.listProduct)));
                },
                child: Container(
                  height: 30,
                  width: 40,
                  color: Colors.red,
                  child: Center(
                      child: Text(
                    "${state.listProduct.length}",
                    style: const TextStyle(color: Colors.white),
                  )),
                ),
              );
            },
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                if (state.status.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status.isLoaded) {
                  return ListView.builder(
                      itemCount: state.product.length,
                      itemBuilder: (context, index) {
                        return _elementProduct(state.product[index]);
                      });
                } else {
                  return const Text("Error");
                }
              }))),
    );
  }

  Widget _elementProduct(Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ProductDetails(product: product)));
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffffffff)),
            child: Column(
              children: [
                _buildProductImage(product.thumbnail),
                const SizedBox(height: 4),
                _buildProductTitle(product.title),
                _buildProductDetail(product),
              ],
            ),
          ),
        ),
        const FavoriteProduct()
      ]),
    );
  }

  Widget _buildProductDetail(Product product) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "\$${product.price}",
            style: const TextStyle(color: textPriceColor),
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return _buildBuyButton(context, product);
            },
          )
        ],
      ),
    );
  }

  Widget _buildBuyButton(BuildContext context, Product product) {
    return ElevatedButton(
        onPressed: () {
          BlocProvider.of<CartBloc>(context)
              .add(AddProductToCartEvent(product: product));
        },
        child: const Text("Buy"));
  }

  Widget _buildProductTitle(String? title) {
    return Text(
      title ?? " ",
      style: const TextStyle(color: textTitleColor, fontSize: 20),
    );
  }

  Widget _buildProductImage(String? thumbnail) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: Image.network(
        thumbnail ?? " ",
        fit: BoxFit.fill,
      ),
    );
  }
}

class FavoriteProduct extends StatefulWidget {
  const FavoriteProduct({
    super.key,
  });

  @override
  State<FavoriteProduct> createState() => _FavoriteProductState();
}

class _FavoriteProductState extends State<FavoriteProduct> {
  bool? isCheckColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8, right: 8),
        child: Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () {
                setState(() {
                  isCheckColor = isCheckColor == null ? true : !isCheckColor!;
                });
              },
              icon: Container(
                  decoration: BoxDecoration(
                      color: isCheckColor == true ? Colors.red : Colors.white,
                      shape: BoxShape.circle),
                  child: Icon(Icons.favorite_border,
                      color:
                          isCheckColor == true ? Colors.white : Colors.black))),
        ));
  }
}
