import 'package:app/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  ProductDetailPage(this.product);

  final String appBarText = "Product Details";

  @override
  Widget build(BuildContext context) {
    final String productId = "Product ID: ${product.id}";
    final String productTitle = "Product Title: ${product.title}";
    final String productBody = "Product Body: ${product.body}";
    return Scaffold(
      appBar: AppBar(
        title: Text('$appBarText'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$productId'),
            Text('$productTitle'),
            Text('$productBody'),
          ],
        ),
      ),
    );
  }
}
