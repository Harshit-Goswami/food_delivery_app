import 'dart:convert';

import 'package:food_delivery_app/modals/cart_modal.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});
  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModal> cartList) {
    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    // sharedPreferences.remove(AppConstants.CART_LIST);
    // return;
    var time = DateTime.now().toString();

    cart = [];
    // for (var element in cartList) {
    //   continue;
    // }
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    // print(sharedPreferences.getStringList(AppConstants.CART_LIST));
  }

  List<CartModal> getCartList() {
    // List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      cart = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("inside getCartList $cart");
    }
    List<CartModal> cartList = [];
    cart.forEach(
        (element) => cartList.add(CartModal.fromJson(jsonDecode(element))));

    return cartList;
  }

  List<CartModal> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModal> cartHistoryList = [];

    cartHistory.forEach((element) =>
        cartHistoryList.add(CartModal.fromJson(jsonDecode(element))));
    return cartHistoryList;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (var i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
      // print("History List" + cartHistory.toString());
    }
    removeCart();
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
    print("the length of the history list is ${getCartHistoryList().length}");

    for (int j = 0; j < getCartHistoryList().length; j++) {
      print(" $j time for the order is " +
          getCartHistoryList()[j].time!.toString());
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}
