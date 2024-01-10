import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/modals/products_modal.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_colors.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_column.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PopularFoodDetail extends StatelessWidget {
  int productIndex;
  String page;
  PopularFoodDetail(
      {required this.productIndex, required this.page, super.key});

  @override
  Widget build(BuildContext context) {
    ProductModal product =
        Get.find<PopularProductController>().popularProductList[productIndex];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            //*background image
            Positioned(
                child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          product.img!),
                      fit: BoxFit.cover)),
            )),
            //*icon widget
            Positioned(
                top: Dimensions.height45,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (page == 'cart_page') {
                            Get.toNamed(RouteHelper.getCartPage());
                          } else {
                            Get.toNamed(RouteHelper.getInitial());
                          }
                        },
                        child: const AppIcon(icon: Icons.arrow_back_ios)),
                    GetBuilder<PopularProductController>(
                      builder: (controller) {
                        return GestureDetector(
                          onTap: () {
                            // if (controller.totalItems >= 1) {
                              Get.toNamed(RouteHelper.getCartPage());
                            // }
                          },
                          child: Stack(children: [
                            const AppIcon(icon: Icons.shopping_cart_outlined),
                            (controller.totalItems) >= 1
                                ? const Positioned(
                                    right: 0,
                                    top: 0,
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: Colors.transparent,
                                      backgroundColor: AppColors.mainColor,
                                    ))
                                : Container(),
                            (controller.totalItems) >= 1
                                ? Positioned(
                                    right: 4,
                                    top: 2,
                                    child: BigText(
                                      text: controller.totalItems.toString(),
                                      size: 12,
                                      color: Colors.white,
                                    ))
                                : Container(),
                          ]),
                        );
                      },
                    ),
                  ],
                )),
            //*introduction of food
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: Dimensions.popularFoodImgSize - Dimensions.height20,
                child: Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        top: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius20),
                            topRight: Radius.circular(Dimensions.radius20)),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppColumn(text: product.name!),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        BigText(text: "Introduce"),
                        Expanded(
                            child: SingleChildScrollView(
                                child: ExpandableTextWidget(
                                    text: product.description!)))
                      ],
                    ))),
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (PopularProduct) {
          return Container(
            height: Dimensions.bottomHeight,
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.height20, horizontal: Dimensions.height20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2)),
                color: AppColors.bottomBackgroundColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(Dimensions.height10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        color: AppColors.signColor,
                        onPressed: () {
                          PopularProduct.setQuality(false);
                        },
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      BigText(text: PopularProduct.quantity.toString()),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: AppColors.signColor,
                        onPressed: () {
                          PopularProduct.setQuality(true);
                        },
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    PopularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.height15,
                        horizontal: Dimensions.width15),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor),
                    child: BigText(
                      text: "\$${product.price!} | Add to Cart",
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
