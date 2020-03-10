import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String titel;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.titel,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            titel: existingCartItem.titel,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              titel: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (currentCartItem) => CartItem(
              titel: currentCartItem.titel,
              price: currentCartItem.price,
              id: currentCartItem.id,
              quantity: currentCartItem.quantity - 1));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
