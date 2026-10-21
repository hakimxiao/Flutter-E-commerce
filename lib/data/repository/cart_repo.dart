import 'dart:convert';

import 'package:flutter_ecommerce/models/cart_model.dart';
import 'package:flutter_ecommerce/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    // CLEANING COMMND
    // sharedPreferences.remove(AppConstants.SHARED_PREFERENCES_KEY_FOR_CART_LIST);
    // sharedPreferences.remove(
    //   AppConstants.SHARED_PREFERENCES_KEY_FOR_CART_HISTORY_LIST,
    // );
    // return;

    var time = DateTime.now().toString();
    cart = [];

    // Convert object to string because shared preferences only except a string
    for (var cartItem in cartList) {
      cartItem.time = time;
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

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(
      AppConstants.SHARED_PREFERENCES_KEY_FOR_CART_HISTORY_LIST,
    )) {
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList(
        AppConstants.SHARED_PREFERENCES_KEY_FOR_CART_HISTORY_LIST,
      )!;
    }

    List<CartModel> cartListHistory = [];

    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }

    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(
      AppConstants.SHARED_PREFERENCES_KEY_FOR_CART_HISTORY_LIST,
    )) {
      cartHistory = sharedPreferences.getStringList(
        AppConstants.SHARED_PREFERENCES_KEY_FOR_CART_HISTORY_LIST,
      )!;
    }

    for (var i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }

    removeCart();
    sharedPreferences.setStringList(
      AppConstants.SHARED_PREFERENCES_KEY_FOR_CART_HISTORY_LIST,
      cartHistory,
    );
  }

  void removeCart() {
    cart = [];

    sharedPreferences.remove(AppConstants.SHARED_PREFERENCES_KEY_FOR_CART_LIST);
  }
}
