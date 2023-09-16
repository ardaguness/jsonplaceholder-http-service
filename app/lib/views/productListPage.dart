import 'package:app/models/product.dart';
import 'package:app/viewmodels/ProductViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatelessWidget {

  final String appBarText = "Product List";

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('$appBarText'),
      ),
      body: ProductBuilder(productViewModel),
    );
  }

  FutureBuilder<List<Product>> ProductBuilder(ProductViewModel productViewModel) {
    return FutureBuilder<List<Product>>(
      future: productViewModel.getHomeProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final products = snapshot.data;
          return ListView.builder(
            itemCount: products?.length,
            itemBuilder: (context, index) {
              final product = products![index];
              return ListTile(
                leading:Text(product.id.toString()),
                title: Text(product.title),
                subtitle: Text(product.body),
              );
            },
          );
        }
      },
    );
  }
}
