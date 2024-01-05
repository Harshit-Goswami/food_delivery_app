import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/modals/products_modal.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_colors.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class RecommendedFoodDetail extends StatelessWidget {
  int productIndex;
  String page;
  RecommendedFoodDetail(
      {super.key, required this.productIndex, required this.page});

  @override
  Widget build(BuildContext context) {
    ProductModal product = Get.find<RecommendedProductController>()
        .recommendedProductList[productIndex];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
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
                    child: const AppIcon(icon: Icons.clear)),
                GestureDetector(
                  onTap: () {},
                  child: GetBuilder<PopularProductController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.totalItems >= 1) {
                            Get.toNamed(RouteHelper.getCartPage());
                          }
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
                                  right: 6,
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
                )
              ],
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                fit: BoxFit.cover,
                width: double.maxFinite,
              ),
            ),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(Dimensions.height20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius15),
                        topRight: Radius.circular(Dimensions.radius15),
                      )),
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: Center(
                      child: BigText(
                    text: product.name!,
                    size: Dimensions.font26,
                  )),
                )),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: ExpandableTextWidget(text: product.description!),
              )
            ],
          )),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20 * 2.5,
                    vertical: Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          controller.setQuality(false);
                        },
                        child: AppIcon(
                          icon: Icons.remove,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.iconSize24,
                        )),
                    BigText(
                      text: "\$${product.price!}  X  ${controller.quantity}",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font26,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setQuality(true);
                      },
                      child: AppIcon(
                        icon: Icons.add,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.iconSize24,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: Dimensions.bottomHeight,
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height20,
                    horizontal: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20 * 2),
                        topRight: Radius.circular(Dimensions.radius20 * 2)),
                    color: AppColors.bottomBackgroundColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          padding: EdgeInsets.all(Dimensions.height20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white),
                          child: const Icon(
                            Icons.favorite,
                            color: AppColors.mainColor,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.height20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor),
                        child: BigText(
                          text:
                              "\$ ${product.price! * controller.quantity} | Add to Cart",
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
