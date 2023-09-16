import 'package:app/utils/IApiService.dart';

import '../models/product.dart';

class ProductService {
  final IApiService apiService;

  ProductService(this.apiService);

  Future<List<Product>> getAllProducts() async {
    final response = await apiService.get('posts');
    return (response as List<dynamic>).map((json) => Product.fromJson(json)).toList();
  }

  Future<Product> getProductById(int id) async {
    final response = await apiService.get('posts/$id');
    return Product.fromJson(response);
  }

  Future<Product> createProduct(Product product) async {
    final response = await apiService.post('products', product.toJson());
    return Product.fromJson(response);
  }

  Future<Product> updateProduct(int id, Product product) async {
    final response = await apiService.put('products/$id', product.toJson());
    return Product.fromJson(response);
  }

  Future<void> deleteProduct(int id) async {
    await apiService.delete('products/$id');
  }
}
