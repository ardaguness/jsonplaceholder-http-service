import 'package:app/models/product.dart';
import 'package:app/services/productService.dart';
import 'package:flutter/material.dart';

class ProductViewModel extends ChangeNotifier {

  final ProductService productService;

  ProductViewModel(this.productService);

  Future<List<Product>> getHomeProducts() async {
    try {
      final products = await productService.getAllProducts();
      return products;
    } catch (e) {
      throw e;
    }
  }
}
