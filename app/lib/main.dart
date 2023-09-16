import 'package:app/services/productService.dart';
import 'package:app/viewmodels/ProductViewModel.dart';
import 'package:app/views/productListPage.dart';
import 'package:flutter/material.dart';
import 'package:app/services/httpService.dart';
import 'package:provider/provider.dart';

void main() {
  final ProductService productService = ProductService(HttpService());
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductViewModel(productService),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:ProductListPage(),
    );
  }
}

