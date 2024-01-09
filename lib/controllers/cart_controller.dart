import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/repositories/cart_repo.dart';
import 'package:food_delivery_app/modals/cart_modal.dart';
import 'package:food_delivery_app/modals/products_modal.dart';
import 'package:food_delivery_app/utils/app_colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModal> _items = {};

  Map<int, CartModal> get items => _items;

  List<CartModal> storageItems = [];

  void addItem(ProductModal product, int quantity) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        return CartModal(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product);
      });
      if (quantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModal(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.img,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString(),
              product: product);
        });
      } else {
        Get.snackbar("Item Count", "You should add at least one item!",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    cartRepo.addToCart(getItems);
    update();
  }

  bool existInCart(ProductModal product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModal product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    int totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModal> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModal> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModal> items) {
    storageItems = items;
    // print("length of cart items "+storageItems.length.toString());
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModal> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }
}
