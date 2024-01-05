import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/app_colors.dart';
import 'package:food_delivery_app/screens/home/food_page_body.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
// import 'package:food_delivery_app_with_backand/app_colors.dart' as AppColors;

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    // print(Dimensions.screenHeight);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(children: [
        //* showing the header
        Container(
          margin: EdgeInsets.only(
              top: Dimensions.height45, bottom: Dimensions.height30),
          padding: EdgeInsets.only(
              left: Dimensions.height20, right: Dimensions.height20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  BigText(
                    text: "India",
                    color: AppColors.mainColor,
                    size: Dimensions.font26,
                  ),
                  Row(
                    children: [
                      SmallText(
                        text: 'Santacruz',
                        color: Colors.black54,
                      ),
                      const Icon(Icons.arrow_drop_down_rounded)
                    ],
                  ),
                ],
              ),
              Container(
                width: Dimensions.height45,
                height: Dimensions.height45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: AppColors.mainColor),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: Dimensions.iconSize24,
                ),
              )
            ],
          ),
        ),
        //*showing the body
        const Expanded(
            child: SingleChildScrollView(
          child: FoodPageBody(),
        ))
      ]),
    );
  }
}
