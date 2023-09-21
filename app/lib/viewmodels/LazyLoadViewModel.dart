import 'package:app/models/product.dart';
import 'package:app/services/productService.dart';
import 'package:flutter/material.dart';

class LazyLoadViewModel extends ChangeNotifier {
  final ProductService productService;
  List<Product> products = [];
  int take = 20;
  int skip = 0;
  bool allDataLoaded = false;

  LazyLoadViewModel(this.productService);

  Future<void> loadMoreData() async {
    if (allDataLoaded) {
      return; // Tüm veriler yüklendiyse işlemi durdur
    }
    try {
      final newProducts = await productService.getPaginationList(skip, take);
      if (newProducts.isEmpty) {
        allDataLoaded = true;
      } else {
        products.addAll(newProducts);
        skip += take;
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
