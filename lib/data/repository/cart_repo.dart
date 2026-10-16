import 'dart:convert';

import 'package:flutter_ecommerce/models/cart_model.dart';
import 'package:flutter_ecommerce/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];

  void addToCartList(List<CartModel> cartList) {
    cart = [];

    // Convert object to string because shared preferences only except a string
    for (var cartItem in cartList) {
      cart.add(jsonEncode(cartItem));
    }

    sharedPreferences.setStringList(
      AppConstants.SHARED_PREFERENCES_KEY_FOR_CART_LIST,
      cart,
    );

    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];

    if (sharedPreferences.containsKey(
      AppConstants.SHARED_PREFERENCES_KEY_FOR_CART_LIST,
    )) {
      carts = sharedPreferences.getStringList(
        AppConstants.SHARED_PREFERENCES_KEY_FOR_CART_LIST,
      )!;
    }

    List<CartModel> cartList = [];

    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }

    return cartList;
  }
}
