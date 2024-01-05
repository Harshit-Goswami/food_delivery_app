import 'dart:convert';

import 'package:food_delivery_app/modals/cart_modal.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  void addToCart(List<CartModal> cartList) {
    cart = [];
    // for (var element in cartList) {
    //   cart.add(jsonEncode(element));
    // }
    cartList.forEach((element) => cart.add(jsonEncode(element)));

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    // print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    getCartList();
  }

  List<CartModal> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      // print("inside getCartList" + carts.toString());
    }
    List<CartModal> cartList = [];
    // for (var element in carts) {
    //   cartList.add(CartModal.fromJson(jsonDecode(element)));
    // }

    carts.forEach((element) => CartModal.fromJson(jsonDecode(element)));
    return cartList;
  }
}
