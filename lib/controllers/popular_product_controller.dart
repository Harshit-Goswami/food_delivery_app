import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/data/repositories/popular_product_repo.dart';
import 'package:food_delivery_app/modals/cart_modal.dart';
import 'package:food_delivery_app/modals/products_modal.dart';
import 'package:food_delivery_app/utils/app_colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  late CartController _cart;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      print('error occur !');
    }
  }

  void setQuality(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      print("number of items = $_quantity");
    } else {
      _quantity = checkQuantity(_quantity - 1);
      print("number of items = $_quantity");
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((quantity) < 0) {
      Get.snackbar("Item Count", "you can't reduce more",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 0;
    } else if ((quantity) > (20)) {
      Get.snackbar("Item Count", "you can't add more",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModal product, CartController cart) {
    _quantity = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    if (exist) {
      _quantity = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModal product) {
    _cart.addItem(product, _quantity);
    _quantity = _cart.getQuantity(product);
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModal> get getItems {
    return _cart.getItems;
  }
}
