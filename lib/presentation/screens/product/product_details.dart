import 'package:flutter/material.dart';
import 'package:hosco_clean_architecture/core/constants/variables.dart';
import 'package:hosco_clean_architecture/domain/entities/product/product.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(product.thumbnail ?? " "),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      product.title ?? " ",
                      style: const TextStyle(
                          color: textProductDetailColor, fontSize: 20),
                    ),
                    Text(
                      "\$${product.price}",
                      style: const TextStyle(color: textProductDetailColor),
                    ),
                    Text(product.description ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: textProductDetailColor, overflow: TextOverflow.visible)),
                    Text("Rating: ${product.rating}",
                        style: const TextStyle(color: textProductDetailColor)),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text("BUY")),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
