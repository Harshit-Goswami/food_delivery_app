import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/screens/auth/sign_up_page.dart';
import 'package:food_delivery_app/utils/app_colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../widgets/app_text_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();

    void login(AuthController authController) {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if (phone.isEmpty) {
        showCustomSnackBar("Type your phone number", title: "Phone Number");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than six characters",
            title: "Password");
      } else {
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            Get.snackbar("Success", "Login Successful",
                backgroundColor: Colors.green, colorText: Colors.white);
            // Get.toNamed(RouteHelper.getInitial());
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.screenHeight * .05,
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight * .20,
                        child: const Center(
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage("assets/image/logo1.png"),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.width20),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello",
                              style: TextStyle(
                                  fontSize: Dimensions.font20 * 4,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Sign into your account",
                              style: TextStyle(
                                fontSize: Dimensions.font20,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height30,
                      ),

                      //! Email
                      AppTextField(
                        textController: phoneController,
                        icon: Icons.phone,
                        hintText: "Phone",
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //! Password
                      AppTextField(
                        textController: passwordController,
                        icon: Icons.password,
                        hintText: "Password",
                        isObscure: true,
                      ),

                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.only(
                            top: Dimensions.height10,
                            right: Dimensions.height20,
                            bottom: Dimensions.height10),
                        child: RichText(
                            textAlign: TextAlign.right,
                            text: TextSpan(
                                text: "Sign into your account",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.font20))),
                      ),
                      SizedBox(
                        height: Dimensions.height20 * 2.5,
                      ),
                      //! SignIn Button
                      GestureDetector(
                        onTap: () {
                          login(authController);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: Dimensions.screenWidth / 2,
                            height: Dimensions.screenHeight / 13,
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                            ),
                            child: BigText(
                              text: "Sign In",
                              color: Colors.white,
                              size: Dimensions.font16 * 2,
                            )),
                      ),
                      SizedBox(
                        height: Dimensions.height10 * 3,
                      ),

                      //! sign Up options
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20),
                          children: [
                            TextSpan(
                                text: "Create",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(const SignUpPage(),
                                      transition: Transition.fade),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: Dimensions.font20))
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const CustomLoader();
        }));
  }
}
