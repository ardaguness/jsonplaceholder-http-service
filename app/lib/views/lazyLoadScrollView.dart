import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/viewmodels/LazyLoadViewModel.dart';

class LazyLoadingScrollView extends StatefulWidget {
  @override
  _LazyLoadingScrollViewState createState() => _LazyLoadingScrollViewState();
}

class _LazyLoadingScrollViewState extends State<LazyLoadingScrollView> {
  final String appBarText = "Product List";
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // İlk 20 veriyi yükle
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final lazyLoadViewModel = Provider.of<LazyLoadViewModel>(context, listen: false);
      lazyLoadViewModel.loadMoreData();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Kullanıcı sayfayı aşağı doğru kaydırdıkça daha fazla veri yükle
      final lazyLoadViewModel = Provider.of<LazyLoadViewModel>(context, listen: false);
      lazyLoadViewModel.loadMoreData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$appBarText'),
      ),
      body: Consumer<LazyLoadViewModel>(
        builder: (context, lazyLoadViewModel, child) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: lazyLoadViewModel.products.length + 1, // Ek bir öğe (loading bar) ekleyin
            itemBuilder: (context, index) {
              if (index < lazyLoadViewModel.products.length) {
                final product = lazyLoadViewModel.products[index];
                return ListTile(
                  leading: Text(product.id.toString()),
                  title: Text(product.title),
                  subtitle: Text(product.body),
                );
              } else if (lazyLoadViewModel.allDataLoaded) {
                // Tüm veriler yüklendiğinde mesaj gösterin
                return Center(child: Text('Tüm veriler yüklendi.'));
              } else {
                // Veriler yüklenirken loading bar gösterin
                return Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }
}
