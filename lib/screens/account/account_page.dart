import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/account_widget.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile",
          size: 24,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          children: [
            AppIcon(
              icon: Icons.person,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              size: Dimensions.height15 * 10,
              iconSize: Dimensions.height15 * 5,
            ),
            SizedBox(
              height: Dimensions.height30,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: (Dimensions.height10 * 5) / 2,
                          size: Dimensions.height10 * 5,
                        ),
                        bigText: BigText(text: "Harshit")),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    //! phone

                    AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.phone,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: (Dimensions.height10 * 5) / 2,
                          size: Dimensions.height10 * 5,
                        ),
                        bigText: BigText(text: "123456789")),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    //! email

                    AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.email,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: (Dimensions.height10 * 5) / 2,
                          size: Dimensions.height10 * 5,
                        ),
                        bigText: BigText(text: "Harshit@hjsdgjs123.coom")),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    //! address

                    AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.location_on,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: (Dimensions.height10 * 5) / 2,
                          size: Dimensions.height10 * 5,
                        ),
                        bigText: BigText(text: "Find the Location")),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    //! message

                    AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.message_outlined,
                          backgroundColor: Colors.redAccent,
                          iconColor: Colors.white,
                          iconSize: (Dimensions.height10 * 5) / 2,
                          size: Dimensions.height10 * 5,
                        ),
                        bigText: BigText(text: "Messages")),

                    //! logout
                    GestureDetector(
                      onTap: () {
                        if (Get.find<AuthController>().userLoggedIn()) {
                          Get.find<AuthController>().clearSharedData();
                          Get.find<CartController>().clearCartHisotry();
                          Get.find<CartController>().clear();
                          Get.offNamed(RouteHelper.getSignInPage());
                        }
                      },
                      child: AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.logout,
                            backgroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            iconSize: (Dimensions.height10 * 5) / 2,
                            size: Dimensions.height10 * 5,
                          ),
                          bigText: BigText(text: "Log Out")),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
