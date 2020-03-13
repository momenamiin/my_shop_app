import 'package:flutter/material.dart';
import 'package:my_shop/models/http_exception.dart';
import 'package:my_shop/provider/products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsProvider with ChangeNotifier {
  List<Product> _list = [];

  List<Product> get list {
    return [..._list];
  }

  List<Product> get FavoriteList {
    return _list.where((product) => product.isFavorite).toList();
  }

  Future<void> fetchAndSetProducts() async {
    const url = 'https://flutter-shop-161d4.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProduct = [];
      extractedData.forEach((prodId, prodData) {
        loadedProduct.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite: prodData['isFavorite'],
        ));
      });
      _list = loadedProduct;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://flutter-shop-161d4.firebaseio.com/products.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          }));
      final newProduct = Product(
        title: product.title,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _list.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  void updateProduct(String id, Product newproduct) async {
    final prodidex = _list.indexWhere((prod) => prod.id == id);
    if (prodidex >= 0) {
      final url = 'https://flutter-shop-161d4.firebaseio.com/products/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newproduct.title,
            'description': newproduct.description,
            'price': newproduct.price,
            'imageUrl': newproduct.imageUrl,
          }));
      _list[prodidex] = newproduct;
      notifyListeners();
    } else {
      print('....');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://flutter-shop-161d4.firebaseio.com/products/$id.json';
    final existingProductIndex = _list.indexWhere((prod) => prod.id == id);
    var existingProduct = _list[existingProductIndex];
    _list.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _list.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('could not delete product');
    }
    existingProduct = null;
  }

  Product findById(String id) {
    return _list.firstWhere((product) => product.id == id);
  }
}
