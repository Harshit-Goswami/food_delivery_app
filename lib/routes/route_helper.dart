import 'package:food_delivery_app/screens/cart/cart_page.dart';
import 'package:food_delivery_app/screens/food/popular_food_detail.dart';
import 'package:food_delivery_app/screens/food/recommended_food_detail.dart';
import 'package:food_delivery_app/screens/home/home_page.dart';
import 'package:food_delivery_app/screens/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashScreen = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getSplashScreen() => "$splashScreen";
  static String getInitial() => "$initial";
  static String getPopularFood(int productId, String page) =>
      "$popularFood?productId=$productId&page=$page";
  static String getRecommendedFood(int productId, String page) =>
      "$recommendedFood?productId=$productId&page=$page";
  static String getCartPage() => "$cartPage";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(
        name: popularFood,
        page: () {
          var productId = Get.parameters['productId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(
            productIndex: int.parse(productId!),
            page: page!,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var productId = Get.parameters['productId'];
          var page = Get.parameters['page'];

          return RecommendedFoodDetail(
              productIndex: int.parse(productId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        transition: Transition.fadeIn),
  ];
}

