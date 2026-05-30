import 'package:flutter/material.dart';

import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartService extends ChangeNotifier {

  CartService._();

  static final CartService instance =
      CartService._();

  final List<CartItemModel> _items = [];

  List<CartItemModel> get items =>
      _items;

  void addToCart(ProductModel product) {

    final index = _items.indexWhere(
      (item) =>
          item.product.id == product.id,
    );

    if (index >= 0) {

      _items[index].quantity++;

    } else {

      _items.add(
        CartItemModel(product: product),
      );
    }

    notifyListeners();
  }

  void removeFromCart(int productId) {

    _items.removeWhere(
      (item) =>
          item.product.id == productId,
    );

    notifyListeners();
  }

  void incrementQuantity(
      int productId) {

    final item = _items.firstWhere(
      (item) =>
          item.product.id == productId,
    );

    item.quantity++;

    notifyListeners();
  }

  void decrementQuantity(
      int productId) {

    final item = _items.firstWhere(
      (item) =>
          item.product.id == productId,
    );

    if (item.quantity > 1) {

      item.quantity--;

    } else {

      removeFromCart(productId);
    }

    notifyListeners();
  }

  double get totalPrice {

    double total = 0;

    for (final item in _items) {
      total += item.total;
    }

    return total;
  }
}