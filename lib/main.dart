import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/screens/auth/sign_in_page.dart';
import 'package:food_delivery_app/screens/auth/sign_up_page.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dept;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dept.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle
    //     (statusBarColor: Colors.transparent));

    Get.find<CartController>().getCartData();

    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(
          builder: (_) {
            return GetMaterialApp(
              title: 'Food delivery',
              debugShowCheckedModeBanner: false,
              // home: const SignInPage(),
              initialRoute: RouteHelper.getSplashScreen(),
              getPages: RouteHelper.routes,
            );
          },
        );
      },
    );
  }
}
