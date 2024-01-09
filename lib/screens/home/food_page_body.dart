import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/modals/products_modal.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/utils/app_colors.dart';
import 'package:food_delivery_app/widgets/app_column.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../widgets/icon_and_text_widget.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: .85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //* slider section
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return popularProducts.isLoaded
                ? SizedBox(
                    height: Dimensions.pageView,
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      },
                    ),
                  )
                : const CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          },
        ),
        //* dots
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty
                  ? 1
                  : popularProducts.popularProductList.length,
              position: _currentPageValue.toInt(),
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeColor: AppColors.mainColor,
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          },
        ),
        //* popular text
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.height30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: SmallText(
                  text: "Food pairing",
                ),
              ),
            ],
          ),
        ),

        //* list of food and image
        GetBuilder<RecommendedProductController>(
          builder: (recommendedProduct) {
            return recommendedProduct.isLoaded
                ? ListView.builder(
                    itemCount: recommendedProduct.recommendedProductList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      ProductModal rProduct =
                          recommendedProduct.recommendedProductList[index];

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                              RouteHelper.getRecommendedFood(index, 'initial'));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.height20,
                              right: Dimensions.height20,
                              bottom: Dimensions.height10),
                          child: Row(
                            children: [
                              //* image section
                              Container(
                                height: Dimensions.listViewImgSize,
                                width: Dimensions.listViewImgSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: Colors.white38,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            AppConstants.BASE_URL +
                                                AppConstants.UPLOAD_URL +
                                                rProduct.img!),
                                        fit: BoxFit.cover)),
                              ),
                              //*text container
                              Expanded(
                                child: Container(
                                  height: Dimensions.listViewTextContSize,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              Dimensions.radius20),
                                          bottomRight: Radius.circular(
                                              Dimensions.radius20)),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Dimensions.width10,
                                        right: Dimensions.width10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BigText(text: rProduct.name!),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        SmallText(
                                            text:
                                                'With Indian Characteristics'),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconAndTextWidget(
                                              text: 'Normal',
                                              icon: Icons.circle_sharp,
                                              iconColor: AppColors.iconColor1,
                                            ),
                                            IconAndTextWidget(
                                              text: '1.7Km',
                                              icon: Icons.location_on,
                                              iconColor: AppColors.mainColor,
                                            ),
                                            IconAndTextWidget(
                                              text: '32min',
                                              icon: Icons.access_time_rounded,
                                              iconColor: AppColors.iconColor2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          },
        ),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModal product) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);

      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RouteHelper.getPopularFood(index, 'initial'));
        },
        child: Stack(
          children: [
            Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  color: index.isEven
                      ? const Color(0xFF69c5df)
                      : const Color(0xFF9294cc),
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  image: DecorationImage(
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          product.img!),
                      fit: BoxFit.cover)),
              // child: ,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: Dimensions.pageViewTextContainer,
                  margin: EdgeInsets.only(
                      left: Dimensions.width30,
                      right: Dimensions.width30,
                      bottom: Dimensions.width30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xFFe8e8e8),
                            blurRadius: 5.0,
                            offset: Offset(0, 5)),
                        BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                        BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                      ]),
                  child: Container(
                      padding: EdgeInsets.only(
                          // top: Dimensions.height10, //!tytyt
                          left: Dimensions.width15,
                          right: Dimensions.width15),
                      child: AppColumn(text: product.name!))),
            ),
          ],
        ),
      ),
    );
  }
}
